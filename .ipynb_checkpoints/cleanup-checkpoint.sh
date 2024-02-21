#!/bin/bash
ids=(
f7fe1ca1-d27c-4798-a5d5-5b46d161845c 6a0cc711-51ec-4c28-9f15-c7be832062df 1fc656e6-45a6-49ba-bbf2-a075f339a67b
70c6b9bc-cfb4-4761-ba5e-8694a9b1213f 1e2142c6-38ea-4544-bea2-5aefcc824d60 53724b10-0da7-4609-8975-bc46903820e4
ade52844-c0ba-49b1-9d48-2340ea2d4d7e 5bc50dc9-4094-4aee-a331-525e167276c3 11625414-1f4b-4725-ae6d-ce0a79329fa5 )
for i in "${ids[@]}"
do
    PYTHONPATH=$PYTHONPATH:$HOME/projects/ngc-cli python bin/ngc.py pym cluster remove $i
done
