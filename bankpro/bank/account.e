note
	description: "[
	R1: Account balances never exceed the credit limit
	R2: Clients can deposit and withdraw dollars
	R3: Tellers (but not clients) can date a dollar deposit or withdrawal differently than today (e.g. as -``tomorrow'')
	R4: Tellers (but not clients) can access withdrawals on a given date
	R5: Maximum total withdrawal per day is $5000
	R6: Clients can access the total amount of dollars deposited and dollars withdrawn from their account
		]"
	author: "Shovon"
	date: "$Date$"
	revision: "$Revision$"

class
	ACCOUNT
create -- declare possible features that can be used as constructors
	make

feature  -- Attributes

	balance : INTEGER
	credit  : INTEGER

	deposits : LIST[TRANSACTION]
				--history of deposits
	withdrawls: LIST[TRANSACTION]
				-- history of withdrawls


feature --Constructor

	make(a_credit: INTEGER)
		--initializes account credit with a_credit
		do
			balance := 0
			credit  := a_credit
			create {LINKED_LIST[TRANSACTION]} deposits.make
			create {LINKED_LIST[TRANSACTION]} withdrawls.make
		ensure
			Zero_balance:
			balance = 0

			credit_properly_set:
			credit = a_credit

			empty_deposits:
				deposits.empty
			empty_withdrawls:
				withdrawls.count = 0


		end

feature -- Commands

	withdraw(amount: INTEGER)
				--withdraw from account today
		require
			non_negative_amount:
				amount > 0
			not_to_big:
				amount <= balance + credit

		local
			t: TRANSACTION
			d: DATE
		do
			balance:= balance - amount

			create d.make_now
			create t.make (amount, d)
			withdrawls.extend(t)


		ensure
			balance_set:
			balance = old balance - amount

			credit_set:
			credit = old credit

			withdrawls_extended:
			withdrawls.count = old withdrawls.count + 1

			deposits_unchanged:
			deposits.count = old deposits.count

		end


		withdraw_on_date(amount: INTEGER; d: DATE)
							--withdraw from account on specified date
			require
				non_negative_amount:
					amount > 0
				not_to_big:
					amount <= balance + credit

			local
				t: TRANSACTION

			do
				balance:= balance - amount
				create t.make (amount, d)
				withdrawls.extend(t)


			ensure
				balance_set:
				balance = old balance - amount

				credit_set:
				credit = old credit

				withdrawls_extended:
				withdrawls.count = old withdrawls.count + 1

				deposits_unchanged:
				deposits.count = old deposits.count

			end

		deposit(amount: INTEGER)
			require
				non_negative_amount:
					amount > 0
			--	not_to_big:
			--		amount <= balance + credit

			local
				t: TRANSACTION
				d: DATE
			do
				balance:= balance + amount

				create d.make_now
				create t.make (amount, d)
				deposits.extend(t)


			ensure
				balance_set:

				balance = old balance + amount
				credit_set:
				credit = old credit
				deposits_extended:
				deposits.count = old deposits.count + 1

				withdrawls_unchanged:
				withdrawls.count = old withdrawls.count

			end

			deposit_on_date(amount: INTEGER; d: DATE)
			require
				non_negative_amount:
					amount > 0
			local
				t: TRANSACTION
			do
				balance:= balance + amount
				create t.make (amount, d)
				deposits.extend(t)


			ensure
				balance_set:

				balance = old balance + amount
				credit_set:
				credit = old credit
				deposits_extended:
				deposits.count = old deposits.count + 1

				withdrawls_unchanged:
				withdrawls.count = old withdrawls

			end
feature -- Queries

			withdrawls_on(d:DATE): ARRAY[TRANSACTION]
									--RETURNS AN ARRAY LF WITHDRAWLS ON DATE 'd'	
				local
					t: TRANSACTION
					i: INTEGER

				do
					create Result.make_empty

					--to make sure when calling Result.has(t)
					-- 't' is considered as contained in array iff
					-- the date and value of 't' match any of the
					-- stored transactions in result
					Result.compare_objects
					check Result.object_comparison end
					from
						i:= 1
						withdrawls.start
					until
						withdrawls.after
					loop
						t:= withdrawls.item
						if t.date ~ d then

							Result.force(t,i)
							i:=i+1
						end


						withdrawls.forth
					end
					ensure
				end

		withdrawls_today: INTEGER
			local
				today: DATE
				today_withdrawls: ARRAY[TRANSACTION]
				i: INTEGER
				t: TRANSACTION

			do
				create today.make_now
				today_withdrawls := withdrawls_on(today)
				Result:= 0
				from
					i:= today_withdrawls.lower
				until
					i > today_withdrawls.upper
				loop
					t:= today_withdrawls[i]
					Result:= Result + t.value
					i := i +1
				end
			ensure
					state_unchanged:
					balance = old balance and credit = old credit
			end

invariant
	credit_negative_check:
		credit >=0
	balance_not_exceeding_credit:
		balance + credit >=0


end
