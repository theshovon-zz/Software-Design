note
	description: "[
		Summary description for {STUDENT_TESTS}.
		To Do: Students must write thier own tests in this class
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS
inherit
	ES_TEST
	redefine setup end

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

		tree: SORTED_BST[INTEGER,STRING]
				-- instantiation of tree
			attribute
				create Result.make_empty
			end

		s_tree: SORTED_BST[STRING, INTEGER]
				-- instantiation of s_tree
			attribute
				create Result.make_empty
			end

feature{NONE} -- setup

	setup
			-- is executed at the beginning of each test
		do
			create tree.make_empty
			tree.extend (8, "eight")
			tree.extend (3, "three")
			tree.extend (1, "one")
			tree.extend (10, "ten")
			tree.extend (14, "fourteen")
			tree.extend (13, "thirteen")
			tree.extend (6, "six")
			tree.extend (4, "four")
			tree.extend (7, "seven")
			---
			create s_tree.make_empty
			s_tree.extend ("eight", 8)
			s_tree.extend ("three", 3)
			s_tree.extend ("one", 1)
			s_tree.extend ("ten", 10)
			s_tree.extend ("fourteen", 14)
			s_tree.extend ("thirteen", 13)
			s_tree.extend ("six", 6)
			s_tree.extend ("four", 4)
			s_tree.extend ("seven", 7)
		end
feature --my test cases

	t1: BOOLEAN
		local
			n1, n2: BASIC_NODE [STRING, INTEGER]
		do

			comment ("t1: check modified is_equal implementation")
			create n1.make (["Shovon", 112])
			create n2.make (["Drake", 999])
			Result:= true
			if n1.is_equal (n2)  then
				Result := False
			end
			check Result	 end
		end


	t2: BOOLEAN
		local
			root, left , right, r_right, l_left: BASIC_NODE[STRING, INTEGER]
			do
				comment ("t2: sibling check")
				create root.make (["Shovon", 112])
				create left.make (["Drake", 999])
				create right.make ("JOHN", 123)
				create r_right.make ("CRAZY", 456)
				create l_left.make ("DAMN", 6969)
				root.set_left (left)
				root.set_right (right)
--				left.set_parent (root)
--				right.set_parent (root)
				Result:= right.sibling ~ (left)
				check Result end

				right.set_right (r_right)
--				r_right.set_parent (right)
				Result:= r_right.sibling ~ void
				check Result end

				left.set_left (l_left)
--				l_left.set_parent (left)
				Result:= l_left.sibling ~ void
				check Result end

				Result := l_left.parent ~ left and left.sibling ~ right
				check Result end



			end



	t3: BOOLEAN


		do

			comment("t3: describe test t1 here")


			Result := True
		end

	t4: BOOLEAN
		do
			comment("t4: describe test t4 here")
			Result := True
		end
end
