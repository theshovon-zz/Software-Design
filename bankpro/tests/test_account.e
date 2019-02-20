note
	description: "Tests the account class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ACCOUNT


inherit
	ES_TEST

create
		make

feature --collect all tests for account
	make
			--add test cases for account
	do
		add_boolean_case(agent test_acc_creation)
		add_boolean_case(agent test_acc_withdraw)
		add_violation_case_with_tag("not_to_big",agent test_acc_weak_precondition)
		add_boolean_case(agent test_acc_too_strong_precondition)
		add_boolean_case(agent test_acc_too_weak_postcondition)
		add_boolean_case(agent test_transaction_value_and_date)
	end
feature --test_cases

	test_acc_creation: BOOLEAN
					--test creation of account
	local
		acc: ACCOUNT
	do
		comment("t0: Account creation")
		-- instantiate ACCOUNT object with initial credit 100
		create acc.make (10)
		Result := acc.balance = 0 and acc.credit = 10
		check Result end

		create acc.make (100)
		Result := acc.balance = 0 and acc.credit = 100
		check Result end

	end

	test_acc_withdraw: BOOLEAN
					--test withdraw method
		local
			acc: ACCOUNT
		do
			comment("t1: test the withdrawl from the account")
			create acc.make (100)
			Result:= acc.balance = 0 and acc.credit = 100
			check Result end
			acc.withdraw (10)
			Result:= acc.balance = -10 and acc.credit = 100
			check Result end
		end

		test_acc_weak_precondition

		local
			acc: ACCOUNT

			do
				comment("t2: Test precondiion withdrawl weakness")
				create acc.make (10)
				check acc.balance = 0 and acc.credit = 10 end
				acc.withdraw(11)

			end
		test_acc_too_strong_precondition:BOOLEAN

			local
				acc: ACCOUNT

				do
					comment("t3: Test precondiion withdrawl too strong")
					create acc.make (10)
					Result:= acc.balance = 0 and acc.credit = 10
					check Result end
					acc.withdraw(10)
					Result:= acc.balance = -10 and acc.credit = 10
					check Result end

				end

		test_acc_too_weak_postcondition:BOOLEAN

			local
				acc: ACCOUNT

				do
					comment("t4: Test postcondiion withdrawl too weak")
					create acc.make (10)
					Result:= acc.balance = 0 and acc.credit = 10
					check Result end
					acc.withdraw(6)
					Result:= acc.balance = -6 and acc.credit = 10
					check Result end

				end
feature -- Specification test

	test_transaction_value_and_date: BOOLEAN

			local
				acc: ACCOUNT
				today, tomorrow: DATE
				w1, w2, w3 : TRANSACTION
				today_withdrawls : ARRAY[TRANSACTION]

				do
					comment("t5: TEST transaction value and date")
					--create today		
					create today.make_now
					-- create tomorrow
					create tomorrow.make_now
						tomorrow.day_forth
					-- initialize an account with zero credit
					create acc.make (0)
					acc.deposit (5500)
					acc.withdraw_on_date(400, tomorrow)
					acc.withdraw (1000)
					acc.withdraw (4000)
					Result:= acc.balance = 100 and acc.withdrawls_today = 5000
					check Result end
					--
					today_withdrawls := acc.withdrawls_on(today)
					Result := today_withdrawls.count = 2
					check Result end

					 --
					create w1.make (1000, today)
					create w2.make (4000, today)
					create w3.make (400, tomorrow)

					Result:=
					 today_withdrawls.has (w1) and
					 today_withdrawls.has (w2) and
					 not today_withdrawls.has (w3)
					check Result end

				end



end
