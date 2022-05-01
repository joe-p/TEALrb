require_relative '../../lib/tealrb'

class VotingApproval < TEALrb::ContractV2
    @version = 2

    #on_creation = Seq(
    #    [
    #        App.globalPut(Bytes("Creator"), Txn.sender()),
    #        Assert(Txna.application_args.length() == Int(4)),
    #        App.globalPut(Bytes("RegBegin"), Btoi(Txna.application_args[0])),
    #        App.globalPut(Bytes("RegEnd"), Btoi(Txna.application_args[1])),
    #        App.globalPut(Bytes("VoteBegin"), Btoi(Txna.application_args[2])),
    #        App.globalPut(Bytes("VoteEnd"), Btoi(Txna.application_args[3])),
    #        Return(Int(1)),
    #    ]
    #)
    teal def on_creation
        app_global_put('Creator', Txn.sender)
        assert(Txn.num_app_args == 4)
        app_global_put('RegBegin', btoi(Txna.application_args(0)))
        app_global_put('RegEnd', btoi(Txna.application_args(1)))
        app_global_put('VoteBegin', btoi(Txna.application_args(2)))
        app_global_put('VoteEnd', btoi(Txna.application_args(3)))
    end

    # get_vote_of_sender = App.localGetEx(Int(0), App.id(), Bytes("voted"))
    teal def get_vote_of_sender
        app_local_get_ex(0, Txn.application_id, 'voted')
        store 1
        store 0
    end

    # get_vote_of_sender.hasValue()
    teal def vote_of_sender_has_value?
        load(0)
    end

    # get_vote_of_sender.value()
    teal def vote_of_sender_value
        load(1)
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
    #)
    teal def on_closeout
        get_vote_of_sender

        if Global.round <= app_global_get('VoteEnd') && vote_of_sender_has_value?
            app_global_put(vote_of_sender_value, app_global_get(vote_of_sender_value - 1))
        end
        
        teal_return 1
    end

    #on_vote = Seq(
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
    #)
    teal def on_vote
        assert(Global.round >= app_global_get('VoteBegin') && Global.round <= app_global_get('VoteEnd'))
        get_vote_of_sender
        
        if vote_of_sender_has_value?
            teal_return 0
        end

        app_global_put(@choice, @choice_tally + 1)
        app_local_put(0, 'voted', @choice)
        teal_return 1
    end

    def main

        #is_creator = Txn.sender() == App.globalGet(Bytes("Creator"))
        is_creator = Txn.sender == app_global_get('Creator') 
    
        #on_register = Return(
        #    And(
        #        Global.round() >= App.globalGet(Bytes("RegBegin")),
        #        Global.round() <= App.globalGet(Bytes("RegEnd")),
        #    )
        #)
        on_register = teal_return( Global.round >= app_global_get('RegBegin') && Global.round >= app_global_get('RegEnd') )

    
        #choice = Txn.application_args[1]
        @choice = Txna.application_args 1

        #choice_tally = App.globalGet(choice)
        @choice_tally = app_global_get(@choice)
    
        #program = Cond(
        #    [Txn.application_id() == Int(0), on_creation],
        #    [Txn.on_completion() == OnComplete.DeleteApplication, Return(is_creator)],
        #    [Txn.on_completion() == OnComplete.UpdateApplication, Return(is_creator)],
        #    [Txn.on_completion() == OnComplete.CloseOut, on_closeout],
        #    [Txn.on_completion() == OnComplete.OptIn, on_register],
        #    [Txn.application_args[0] == Bytes("vote"), on_vote],
        #)
        if Txn.application_id == 0
            on_creation
        elsif Txn.on_completion == int('DeleteApplication')
            teal_return is_creator
        elsif Txn.on_completion == int('UpdateApplication')
            teal_return is_creator
        elsif Txn.on_completion == int('CloseOut')
            on_closeout
        elsif Txn.on_completion == int('OptIn')
            on_register
        elsif Txna.application_args(0) == 'vote'
            on_vote
        end

        #return program
        teal_return

    end
end

contract = VotingApproval.new
contract.compile
puts contract.teal
