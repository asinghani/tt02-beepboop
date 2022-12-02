module beepboop_tb;

    logic clock, reset, btn;

    // io_out = {1'b0, 1'b0, the_beepbooper, no_walk, walk, green, yellow, red};
    logic [7:0] io_in, io_out;
    assign io_in = {5'b0, btn, reset, clock};

    asinghani_beepboop dut (.*);

    // Who needs $monitor?
    always_comb begin
        $display("[%d] btn=%b rst=%b out=%b", $time, btn, reset, io_out);
    end

    initial begin
        // 100Hz clock, timestep = 1ms
        clock = 1;
        forever #5 clock = ~clock;
    end

    initial begin
        btn = 0;
        reset = 1;
        repeat(10) @(posedge clock);
        reset = 0;
        repeat(990) @(posedge clock);

        repeat (3) begin
            btn = 1;
            repeat(10) @(posedge clock);
            btn = 0;

            repeat(2990) @(posedge clock);
        end

        $finish;
    end

endmodule : beepboop_tb
