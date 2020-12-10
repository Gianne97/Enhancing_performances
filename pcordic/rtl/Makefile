

VHDL_SIM= ghdl
FLAGS=-gPRECISION_FP=$(B)

tb_pcordic: shifter para_S R_block pcordic 
tb_paraS: para_S


all: tb_pcordic

sim:
	ghdl -r tb_pcordic  $(FLAGS) | python3 display_rep.py 

R_block.vhdl:	
	python3 code_gen/gen_pcordic.py $(B) > $@

% : %.vhdl
	$(VHDL_SIM) -a $<
	$(VHDL_SIM) -e $@

clean:
	rm -f R_block.vhdl *.cf

