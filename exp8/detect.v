module detect (input clk, input sw0, input button, output reg [2:0] AN, output reg [3:0] D);
    wire button_edge;
    reg in;
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter DDD = 2'b11;
    integer i = 0;
    reg [1:0] current_state, next_state;
    reg [3:0] count, series;

    always @ *
    begin
        if (button_edge)            // if button is pushed
        begin
            in = sw0;               // update input
            series = series << 1;   // save the series
            series[0] = in;
            if (current_state == DDD && in == 0)  // if there is another '1100
                count = count + 1;              // count++
            case (current_state)                // update states
            A: next_state = in ? B : A;
            B: next_state = in ? C : A;
            C: next_state = in ? C : DDD;
            DDD: next_state = in ? A : B;
            endcase
        end
        else
            next_state = current_state;
    end

    always @ (posedge clk)
        current_state <= next_state;

    always @ (posedge clk)  // should use lower frequencies
    begin
        if (i < 6) // we have 6 things to output
        begin
            AN <= i;
            case (i)
            0: D <= count;
            1: D <= current_state + 10; // from 2'b00 to 4'hA etc.
            2: D <= series[0];
            3: D <= series[1];
            4: D <= series[2];
            5: D <= series[3]; // the series
            endcase
        end
        else i = 0;
        i = i + 1;
    end

    signal_edge se (.clk (clk), .button (button), .button_edge (button_edge));
endmodule


module signal_edge(
    input clk,
    input button,
    output button_edge);
    reg button_r1,button_r2;
    always @ (posedge clk) button_r1 <= button;
    always @ (posedge clk) button_r2 <= button_r1;
    assign button_edge = button_r1 & ~button_r2;
endmodule