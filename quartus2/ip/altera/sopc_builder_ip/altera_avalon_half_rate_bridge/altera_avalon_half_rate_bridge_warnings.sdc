set hrb_warning "This project appears to contain an SOPC Builder system with one or more instances of the Avalon MM Half Rate DDR Memory Bridge component. This component contains multi-cycle timing paths that are unconstrained by default. To constrain them, copy the file located at \$QUARTUS_ROOTDIR/../ip/altera/sopc_builder_ip/altera_avalon_half_rate_bridge/altera_avalon_half_rate_bridge_constraints.sdc into your project directory, open it in a text editor and follow the instructions in the comments to set the slow_clk and instance variables, and source it in your project."
post_message -type warning "${hrb_warning}"