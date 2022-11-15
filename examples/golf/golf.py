#!/usr/bin/env python3

import re
from algosdk.future import transaction
from algosdk.v2client import algod
from algosdk.logic import get_application_address
from algosdk.abi import UintType
from algosdk.error import AlgodHTTPError
from beaker import *
import base64
import random
import json
from pathlib import Path

algod_address = "http://localhost:4001"
algod_token = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
algod_client = algod.AlgodClient(algod_token, algod_address)

f = open("golf.teal")
accounts = sorted(
    sandbox.get_accounts(),
    key=lambda a: sandbox.clients.get_algod_client().account_info(a.address)["amount"],
)

sender = accounts.pop()
approval = base64.b64decode(algod_client.compile(f.read())["result"])

create_txn = transaction.ApplicationCreateTxn(
    sender.address,
    algod_client.suggested_params(),
    on_complete=transaction.OnComplete.NoOpOC,
    approval_program=approval,
    clear_program=approval,
    global_schema=transaction.StateSchema(0, 0),
    local_schema=transaction.StateSchema(0, 0),
)


def add_number(n):
    print(f"Adding number {n}")
    txid = send(
        transaction.ApplicationCallTxn(
            sender=sender.address,
            sp=algod_client.suggested_params(),
            index=app_id,
            on_complete=transaction.OnComplete.NoOpOC,
            boxes=[[0, "ints"], [0, "ints"], [0, "ints"], [0, "ints"]],
            app_args=[n],
        )
    )

    info = algod_client.pending_transaction_info(txid)
    log_array = []

    opcode_budget = UintType(64).decode(base64.b64decode(info["logs"][-1]))

    if len(info["logs"]) > 1:
        decoded = base64.b64decode(info["logs"][0])

        for i in range(0, len(decoded), 2):
            log_array.append(UintType(16).decode(decoded[i : i + 2]))

        print(f"New array: {log_array}")
        print(f"Array length: {len(log_array)}")

    print(f"Opcode budget: {opcode_budget}")
    print("-")

    return opcode_budget


def send(txn):
    try:
        txid = algod_client.send_transaction(txn.sign(sender.private_key))
    except AlgodHTTPError as e:
        pc = int(re.findall("(?<=pc=).*?\d+", str(e))[0])
        src_map = json.load(Path("golf.src_map.json").open())

        teal_line = "Unknown"
        rb_line = "Unknown"
        for teal_ln, data in src_map.items():
            print(data)
            if "pcs" in data.keys() and pc in data["pcs"]:
                teal_line = (
                    Path("golf.teal").read_text().splitlines()[int(teal_ln) - 1].strip()
                )

                teal_line = f"./golf.teal:{teal_ln} => {teal_line}"

                print(data["location"])
                rb_line = (
                    Path("golf.rb")
                    .read_text()
                    .splitlines()[int(data["location"].split(":")[1]) - 1]
                    .strip()
                )

                rb_line = f"./{data['location']} => {rb_line}"
                break

        raise AlgodHTTPError(f"{str(e).splitlines()[0]}\n{teal_line}\n{rb_line}")

    return txid


app_id = algod_client.pending_transaction_info(send(create_txn))["application-index"]

fund_txn = transaction.PaymentTxn(
    sender.address,
    algod_client.suggested_params(),
    receiver=get_application_address(app_id),
    amt=10_000_000,
)

send(fund_txn)

nums = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    111,
    123,
    456,
]

# 508 is largest range that can be logged due to 1k log limitation
# Comment out the log on line 54 of golf.rb to set range up to 2048 (which will hit stack limit)
nums = list(range(508))
random.shuffle(nums)
total_budget = 0
budgets = []
for n in nums:
    print(f"Iteration: {nums.index(n)+1}")
    budget = add_number(n)
    total_budget += budget
    budgets.append(budget)

print(f"Average budget left: {total_budget/len(nums)}")
print(f"Lowest budget left: {min(budgets)}")
