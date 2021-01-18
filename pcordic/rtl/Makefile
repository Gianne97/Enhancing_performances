VHDL_SIM= ghdl


tb: shifter para_S R_block prec_add S_block pcordic tb_pcordic


all: tb

sim:
	ghdl -r tb_pcordic $(FLAGS) | python3 scripts/display_rep.py

wave:
	ghdl -r tb_pcordic  --vcd=wave1.vcd

pcordic.vhdl:
	python3 scripts/gen_pc.py --B=$(B) --name=pcordic.vhdl > $@

prec_add.vhdl:
	python3 scripts/gen_pc.py --B=$(B) --name=prec_add.vhdl > $@

R_block.vhdl:	
	python3 scripts/gen_R_block.py $(B) > $@

tb_pcordic.vhdl:
	python3 scripts/gen_tb.py --B=$(B) --theta=[0.1,0.2,0.5]

% : %.vhdl
	$(VHDL_SIM) -a $< 
	$(VHDL_SIM) -e $@ 

clean:
	echo $(tb)
	rm -f prec_add.vhdl R_block.vhdl pcordic.vhdl tb_pcordic.vhdl wave1.vcd *.cf

.PHONY: sim tb wave
