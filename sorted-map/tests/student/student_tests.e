note
	description: "Summary description for {STUDENT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
		end

feature
	t1: BOOLEAN


		local
			a1, a2 , expect: ARRAY [INTEGER]
			new: UTIL [INTEGER]
		do
			comment ("t3: Check the merging of two arrays")
			a1 := <<1, 3, 5,9>>
			a2 := <<2, 4, 6>>

			expect := <<1, 2, 3, 4, 5, 6,9>>
			Result := expect ~ new.merge (a1, a2)
			check Result end

		end


	t2: BOOLEAN
		local
			a, expect: ARRAY [INTEGER]
			new: UTIL [INTEGER]

		do
			comment("t2: is mergesort working")
			a := <<3, 1, 5,9, 7, 5, 6>>
			expect := <<1, 3, 5, 5, 6, 7, 9>>
			Result:= expect ~ new.merge_sort (a)
			check Result end
		end

	t3: BOOLEAN
		local
			a1, a2 , expect: ARRAY [INTEGER]
			new: UTIL [INTEGER]
		do
			comment("t3: concatenate?")
			a1 := <<1, 3, 5,9>>
			a2 := <<2, 4, 6>>
			expect := <<1, 3, 5, 9,2,4, 6>>
			Result:= expect ~ new.concatenate (a1, a2)
			check Result end
		end

	t4: BOOLEAN


			local
					a1, a2 , expect1, expect2: ARRAY [INTEGER]
					new: UTIL [INTEGER]
				do
					comment("t4: Combination")
					a1 := <<1, 3, 5,9>>
					a2 := <<2, 4, 6>>
					expect1 := <<1, 3, 5, 9,2,4, 6>>
					Result:= expect1 ~ new.concatenate (a1, a2)
					check Result end
					expect2 := <<1, 2, 3, 4, 5, 6, 9 >>
					Result := expect2 ~ new.merge_sort (new.concatenate (a1, a2))
					check Result end
				end
end

