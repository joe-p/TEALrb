# frozen_string_literal: true

require_relative '../../lib/tealrb'

class VotingApproval < TEALrb::Contract
  @version = 2

  # on_creation = Seq(
  #    [
  #        App.globalPut(Bytes("Creator"), Txn.sender()),
  #        Assert(Txna.application_args.length() == Int(4)),
  #        App.globalPut(Bytes("RegBegin"), Btoi(Txna.application_args[0])),
  #        App.globalPut(Bytes("RegEnd"), Btoi(Txna.application_args[1])),
  #        App.globalPut(Bytes("VoteBegin"), Btoi(Txna.application_args[2])),
  #        App.globalPut(Bytes("VoteEnd"), Btoi(Txna.application_args[3])),
  #        Return(Int(1)),
  #    ]
  # )

  # @teal
  def on_creation
    Global['Creator'] = Txn.sender
    assert(Txn.num_app_args == 4)
    Global['RegBegin'] = btoi(AppArgs[0])
    Global['RegEnd'] = btoi(AppArgs[1])
    Global['VoteBegin'] = btoi(AppArgs[2])
    Global['VoteEnd'] = btoi(AppArgs[3])
  end

  # on_closeout = Seq(
  #    [
  #        get_vote_of_sender,
  #        If(
  #            And(
  #                Global.round() <= App.globalGet(Bytes("VoteEnd")),
  #                get_vote_of_sender.hasValue(),
  #            ),
  #            App.globalPut(
  #                get_vote_of_sender.value(),
  #                App.globalGet(get_vote_of_sender.value()) - Int(1),
  #            ),
  #        ),
  #        Return(Int(1)),
  #    ]
  # )

  # @teal
  def on_closeout
    vote_of_sender = app_global_ex_value(0, Txn.application_id, 'voted')

    if Global.round <= Global['VoteEnd'] && app_global_ex_exists?(0, Txn.application_id, 'voted')
      Global[vote_of_sender] = Global[vote_of_sender] - 1
    end

    teal_return 1
  end

  # on_vote = Seq(
  #    [
  #        Assert(
  #            And(
  #                Global.round() >= App.globalGet(Bytes("VoteBegin")),
  #                Global.round() <= App.globalGet(Bytes("VoteEnd")),
  #            )
  #        ),
  #        get_vote_of_sender,
  #        If(get_vote_of_sender.hasValue(), Return(Int(0))),
  #        App.globalPut(choice, choice_tally + Int(1)),
  #        App.localPut(Int(0), Bytes("voted"), choice),
  #        Return(Int(1)),
  #    ]
  # )

  # @teal
  def on_vote
    assert(Global.round >= Global['VoteBegin'] && Global.round <= Global['VoteEnd'])

    if app_global_ex_exists?(0, Txn.application_id, 'voted')
      teal_return 0
    end

    Global[@choice] = @choice_tally + 1
    Local[0]['voted'] = @choice
    teal_return 1
  end

  def main
    # is_creator = Txn.sender() == App.globalGet(Bytes("Creator"))
    is_creator = Txn.sender == Global['Creator']

    # on_register = Return(
    #    And(
    #        Global.round() >= App.globalGet(Bytes("RegBegin")),
    #        Global.round() <= App.globalGet(Bytes("RegEnd")),
    #    )
    # )
    on_register = teal_return(Global.round >= Global['RegBegin'] && Global.round >= Global['RegEnd'])

    # choice = Txn.application_args[1]
    @choice = Txna.application_args[1]

    # choice_tally = App.globalGet(choice)
    @choice_tally = Global[@choice]

    # program = Cond(
    #    [Txn.application_id() == Int(0), on_creation],
    #    [Txn.on_completion() == OnComplete.DeleteApplication, Return(is_creator)],
    #    [Txn.on_completion() == OnComplete.UpdateApplication, Return(is_creator)],
    #    [Txn.on_completion() == OnComplete.CloseOut, on_closeout],
    #    [Txn.on_completion() == OnComplete.OptIn, on_register],
    #    [Txn.application_args[0] == Bytes("vote"), on_vote],
    # )
    if Txn.application_id == 0
      on_creation
    elsif Txn.on_completion == int('DeleteApplication')
      teal_return is_creator
    elsif Txn.on_completion == int('UpdateApplication') # rubocop:disable Lint/DuplicateBranch
      teal_return is_creator
    elsif Txn.on_completion == int('CloseOut')
      on_closeout
    elsif Txn.on_completion == int('OptIn')
      on_register
    elsif Txna.application_args[0] == 'vote'
      on_vote
    end

    # return program
    teal_return
  end
end

contract = VotingApproval.new
contract.compile
File.write("#{__dir__}/voting_tealrb.teal", contract.teal_source)
