note
	description: "Transaction encapsulates a pair of deposit/withdraw pair with time stamp"
	author: "Shovon Saha"
	date: "$Date$"
	revision: "$Revision$"

class
	TRANSACTION
inherit
		ANY
			redefine
				is_equal
			end

	create
		make
feature -- constructor
	make(v: INTEGER ; d: DATE)
			--initialise a transaction with value and date
			do
				value:= v
				date:= d
			ensure
				set_value:
				value = v
				set_date:
				date = d
			end
feature -- Equality

		is_equal(other: like Current): BOOLEAN --anchor type
				--are the Dates and value of two transactions equal
			do
				Result:=
				 	value = other.value and
				 	date ~ other.date
			end
feature --attributes

	Value: INTEGER
	date: DATE

	invariant
		valid_value:
		value > 0
end
