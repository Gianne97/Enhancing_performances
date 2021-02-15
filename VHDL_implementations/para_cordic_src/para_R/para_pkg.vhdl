package para_pkg is
    function N_OF_I (PARAMETER_I, PRECISION_THETA : integer) return integer;
    function Si_OF_I (PARAMETER_I, PRECISION_THETA, J : integer) return integer;

    type SI_TABLE_1_T is array (0 to 10) of integer range 0 to 23;
    type SI_TABLE_2_T is array (0 to 6) of integer range 0 to 22 ;
    type SI_TABLE_3_T is array (0 to 5) of integer range 0 to 22 ;
    type SI_TABLE_4_T is array (0 to 4) of integer range 0 to 20 ;
    type SI_TABLE_5_T is array (0 to 4) of integer range 0 to 23 ;
    type SI_TABLE_6_T is array (0 to 2) of integer range 0 to 22 ;
    type SI_TABLE_7_T is array (0 to 1) of integer range 0 to 23 ;
    


    constant SI_TABLE_1 : SI_TABLE_1_T := (1,5,8,10,13,14,15,16,21,22,23);
    constant SI_TABLE_2 : SI_TABLE_2_T := (2,8,10,13,16,20,22);
    constant SI_TABLE_3 : SI_TABLE_3_T := (3,11,13,15,18,22);
    constant SI_TABLE_4 : SI_TABLE_4_T := (4,14,16,18,20);
    constant SI_TABLE_5 : SI_TABLE_5_T := (5,17,19,21,23);
    constant SI_TABLE_6 : SI_TABLE_6_T := (6,20,22);
    constant SI_TABLE_7 : SI_TABLE_7_T := (7,23);


end package;

package body para_pkg is
    function N_OF_I (PARAMETER_I, PRECISION_THETA : integer) return integer is
    begin
        case PRECISION_THETA is
            when 16 =>
                case PARAMETER_I is
                    when 1 => return 2;
                    when others => return 1;
                end case;
            when 24 =>
                case PARAMETER_I is
                    when 1 => return 3;
                    when 2 => return 2;
                    when others => return 1;
                end case;
            when 32 =>
                case PARAMETER_I is
                    when 1 => return 5;
                    when 2 => return 3;
                    when 3 => return 3;
                    when others => return 1;
                end case;
            when 54 =>
                case PARAMETER_I is
                    when 1 => return 8;
                    when 2 => return 5;
                    when 3 => return 5;
                    when 4 => return 4;
                    when 5 => return 3;
                    when 6 => return 2;
                    when others => return 1;
                end case;
            when 64 =>
                case PARAMETER_I is
                    when 1 => return 11;
                    when 2 => return 7;
                    when 3 => return 6;
                    when 4 => return 5;
                    when 5 => return 5;
                    when 6 => return 3;
                    when 7 => return 2;
                    when others => return 1;
                end case;
	    when others => 
		return 0; 
        end case;
    end function;

    function Si_OF_I (PARAMETER_I, PRECISION_THETA, J : integer) return integer is
    begin
        if (J >= N_OF_I(PARAMETER_I, PRECISION_THETA)) or (J < 0) then
            return 0;
        end if;

        case PRECISION_THETA is
            when 16 =>
                case PARAMETER_I is
                    when 1 => return SI_TABLE_1(J);
                    when others => return PARAMETER_I;
                end case;
            when 24 =>
                case PARAMETER_I is
                    when 1 => return SI_TABLE_1(J);
                    when 2 => return SI_TABLE_2(J);
                    when others => return PARAMETER_I;
                end case;
            when 32 =>
                case PARAMETER_I is
                    when 1 => return SI_TABLE_1(J);
                    when 2 => return SI_TABLE_2(J);
                    when 3 => return SI_TABLE_3(J);
                    when others => return PARAMETER_I;
                end case;
            when 54 =>
                case PARAMETER_I is
                    when 1 => return SI_TABLE_1(J);
                    when 2 => return SI_TABLE_2(J);
                    when 3 => return SI_TABLE_3(J);
                    when 4 => return SI_TABLE_4(J);
                    when 5 => return SI_TABLE_5(J);
                    when 6 => return SI_TABLE_6(J);
                    when others => return PARAMETER_I;
                end case;
            when 64 =>
                case PARAMETER_I is
                    when 1 => return SI_TABLE_1(J);
                    when 2 => return SI_TABLE_2(J);
                    when 3 => return SI_TABLE_3(J);
                    when 4 => return SI_TABLE_4(J);
                    when 5 => return SI_TABLE_5(J);
                    when 6 => return SI_TABLE_6(J);
                    when 7 => return SI_TABLE_7(J);
                    when others => return PARAMETER_I;
                end case;
	    when others => 
		return 0; 
        end case;
    end function;
end para_pkg;