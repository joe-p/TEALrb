from typing import Final
from algosdk import *
from pyteal import *
from beaker import *


class NumberOrder(Application):

    declared_count: Final[ApplicationStateValue] = ApplicationStateValue(
        stack_type=TealType.uint64,
        default=Int(0),
        descr="wouldnt you like to know",
    )

    @external
    def add_int(self,val: abi.Uint64, *, output: abi.DynamicArray[abi.Uint64]):
    #def add_int(self,val: abi.Uint64):
        i = ScratchVar(TealType.uint64)
        return Seq(
            boxint :=  App.box_get(Bytes("BoxA")),
            Assert(boxint.hasValue()),
            #(offset := ScratchVar()).store(Int(0)),
            For(i.store(Int(0)), i.load() <= self.declared_count.get(), i.store(i.load() + Int(1))).Do(
                #offset.store(i.load()*Int(8)), 
                If(i.load() == self.declared_count.get(), 
                   Seq(
                    App.box_replace(Bytes("BoxA"), i.load()*Int(8), Concat(val.encode(),(App.box_extract(Bytes("BoxA"), i.load()*Int(8), ((self.declared_count.get() + Int(1) - i.load()) * Int(8))) ))),
                    self.declared_count.set(self.declared_count.get() + Int(1)),
                    Break()),
                ),                
                If( (val.get() < Btoi(App.box_extract(Bytes("BoxA"), i.load()*Int(8), Int(8)))),
                   Seq(
                    App.box_replace(Bytes("BoxA"), i.load() * Int(8), Concat(val.encode(),(App.box_extract(Bytes("BoxA"), i.load()*Int(8), ((self.declared_count.get() + Int(1) - i.load()) * Int(8))) ))),
                    self.declared_count.set(self.declared_count.get() + Int(1)),
                    Break()),
                ),
                
            ),
            Log(Itob(Global.opcode_budget())),
            output.decode(
            # Prepend the bytes with the number of elements as a uint16, according to ABI spec
            Concat(Suffix(Itob(self.declared_count.get()), Int(6)), App.box_extract(Bytes("BoxA"),Int(0), Int(8) * self.declared_count.get()))
            ),
    )
        
    @external
    def box_create_test(self):
        return Seq(
            Assert(App.box_create(Bytes("BoxA"), Int(1000))),
            self.declared_count.set(Int(0)),
        )
        
        
if __name__ == "__main__":
    accts = sandbox.get_accounts()
    acct = accts.pop()
    acct2 = accts.pop()

    app_client = client.ApplicationClient(
        sandbox.get_algod_client(), NumberOrder(), signer=acct.signer
    )
    NumberOrder().dump('./artifacts')
    #atc = AtomicTransactionComposer()
    #atc.add_method_call()
    app_client.create()
    app_client.fund(100 * consts.algo)
    print("APPID")
    print(app_client.app_id)
    print(app_client.app_addr)
    ls = acct.address.encode()



    result = app_client.call(
        NumberOrder.box_create_test,
        boxes=[[app_client.app_id, "BoxA"]],
    )
    for x in range(23): 
        result1 = app_client.call(
            NumberOrder.add_int,
            val=x,
            boxes=[[app_client.app_id, "BoxA"]],
        )
    result2 = app_client.call(
        NumberOrder.add_int,
        val=123,
        boxes=[[app_client.app_id, "BoxA"]],
    ) 
    result3 = app_client.call(
        NumberOrder.add_int,
        val=456,
        boxes=[[app_client.app_id, "BoxA"]],
    )
    
    result4 = app_client.call(
        NumberOrder.add_int,
        val=111,
        boxes=[[app_client.app_id, "BoxA"]],
    )     

    print(result.return_value)

    
    print(result2.return_value)
    import base64
    budget = int.from_bytes(base64.b64decode(result2.tx_info['logs'][0]), 'big')
    print(f"Budget: {budget}")
    #print(result2.tx_info['logs'])
    print(result3.return_value)
    budget = int.from_bytes(base64.b64decode(result3.tx_info['logs'][0]), 'big')
    print(f"Budget: {budget}")

    print(result4.return_value)
    budget = int.from_bytes(base64.b64decode(result4.tx_info['logs'][0]), 'big')
    print(f"Budget: {budget}")