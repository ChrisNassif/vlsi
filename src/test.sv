module fpga_vthacks(
    input logic clock,
    input logic [31:0] button_array,
    output logic uart_tx
);

    logic divided_clock64;
    logic is_uart_send_finished;
    logic [31:0] button_array_buffer;
    logic initiate_send_signal_uart;
    
    
    clock_divider_64 clock_divider(.clock_in(clock), .reset(1'b0), .clock_out(divided_clock64));


    // send values from button array to uart -------------------------------------------------------
    assign initiate_send_signal_uart = 1;
    register_to_uart register_to_uart(
        .clock(divided_clock64), .initiate_send_signal_uart(initiate_send_signal_uart), 
        .data_to_send(button_array_buffer), .uart_tx(uart_tx), 
        .is_uart_send_finished(is_uart_send_finished)
    );

    always @(posedge is_uart_send_finished) begin
        button_array_buffer <= button_array;
    end

    // ---------------------------------------------------------------------------------------------


endmodule



module clock_divider_64(
    input logic clock_in,
    input logic reset,
    output logic clock_out
);
    logic [8:0] count;

    initial begin
        count <= 0;
    end

    always @(posedge clock_in or posedge reset) begin
        if (reset) begin
            count <= 0;
            clock_out <= 0;
        end 
        
        else begin
            if (count == 64 - 1) begin
                count <= 0;
                clock_out <= ~clock_out; 
            end 
            
            else begin
                count <= count + 1;
            end
        end
    end


endmodule



module register_to_uart (
    input logic clock,
    input logic initiate_send_signal_uart,
    input logic [31:0] data_to_send,
    output logic uart_tx,
    output logic is_uart_send_finished
);
    logic [3:0] bit_counter;
    logic [1:0] packet_counter;

    initial begin
        bit_counter = 0;
        packet_counter = 0;
        uart_tx = 1;
        is_uart_send_finished = 1;
    end

    always @(posedge clock) begin
        
        // write the stop bit
        if (bit_counter == 4'b1001) begin
            uart_tx <= 1;
            bit_counter <= 0;

            if (packet_counter == 2'b11) begin
                packet_counter <= 0;
            end

            else begin
                packet_counter <= packet_counter + 1;
            end
        end

        // normal operation
        else if (bit_counter != 0) begin
            bit_counter <= bit_counter + 1;
            uart_tx <= data_to_send[packet_counter * 8 + (bit_counter-1)];
        end

        // initiate the state machine
        else if (initiate_send_signal_uart && bit_counter == 0) begin
            bit_counter++;
            uart_tx <= 0; 
        end
    end

endmodule