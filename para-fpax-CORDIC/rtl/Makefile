VHDL_SIM= ghdl



pcordic_sim: pcordic_files shifter para_S S_block R_block prec_add pcordic tb
fpax_sim: fpax_files shifter para_S S_block R_block fpax tb

pcordic_files:
	cd scripts && python3 gen_pcordic.py --alg=pcordic --B=$(B)
	mv -f scripts/*.vhdl .
	python3 scripts/gen_tb.py --alg=pcordic --B=$(B) --theta=$(theta)

fpax_files:
	cd scripts && python3 gen_pcordic.py --alg=fpax --B=$(B) --p=$(p)
	mv -f scripts/*.vhdl .
	python3 scripts/gen_tb.py --alg=fpax --B=$(B) --theta=$(theta)


R_block:
	ghdl -a R_block.vhdl
	ghdl -e R_block

prec_add:
	ghdl -a prec_add.vhdl
	ghdl -e prec_add

pcordic:
	ghdl -a pcordic.vhdl
	ghdl -e pcordic

fpax:
	ghdl -a fpax.vhdl
	ghdl -e fpax

tb:
	ghdl -a tb.vhdl
	ghdl -e tb

sim:
	ghdl -r tb $(FLAGS) | python3 scripts/display_rep.py

wave:
	ghdl -r tb  --vcd=wave1.vcd

% : %.vhdl
	$(VHDL_SIM) -a $< 
	$(VHDL_SIM) -e $@ 

clean:
	echo $(tb)
	rm -f prec_add.vhdl R_block.vhdl pcordic.vhdl fpax.vhdl tb.vhdl wave1.vcd *.cf

.PHONY: sim tb wave
