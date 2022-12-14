`include "lib/defines.vh"
module mycpu_core(
    input wire clk,
    input wire rst,
    input wire [5:0] int,

    output wire inst_sram_en,
    output wire [3:0] inst_sram_wen,
    output wire [31:0] inst_sram_addr,
    output wire [31:0] inst_sram_wdata,
    input wire [31:0] inst_sram_rdata,

    output wire data_sram_en,
    output wire [3:0] data_sram_wen,
    output wire [31:0] data_sram_addr,
    output wire [31:0] data_sram_wdata,
    input wire [31:0] data_sram_rdata,

    output wire [31:0] debug_wb_pc,
    output wire [3:0] debug_wb_rf_wen,
    output wire [4:0] debug_wb_rf_wnum,
    output wire [31:0] debug_wb_rf_wdata
);
    wire [`IF_TO_ID_WD-1:0] if_to_id_bus;
    wire [`ID_TO_EX_WD-1:0] id_to_ex_bus;
    wire [`EX_TO_MEM_WD-1:0] ex_to_mem_bus;
    wire [`MEM_TO_WB_WD-1:0] mem_to_wb_bus;
    wire [`BR_WD-1:0] br_bus; 
    wire [`DATA_SRAM_WD-1:0] ex_dt_sram_bus;
    wire [`WB_TO_RF_WD-1:0] wb_to_rf_bus;
    wire [`EX_TO_RF_WD-1:0] ex_to_rf_bus;
    wire [`MEM_TO_RF_WD-1:0] mem_to_rf_bus;
    wire [`StallBus-1:0] stall;
    wire stallreq;
    wire stallreq_for_ex;
    wire [`LoadBus-1:0] id_load_bus;
    wire [`LoadBus-1:0] ex_load_bus;
    wire [3:0] data_ram_sel;
    wire [`SaveBus-1:0] id_save_bus;
    wire pre_inst_is_load;
    wire [`HILO_WD-1:0] id_hilo_bus;
    wire [`EX_HILO_WD-1:0] ex_hilo_bus;

    IF u_IF(
    	.clk             (clk             ),
        .rst             (rst             ),
        .stall           (stall           ),
        .br_bus          (br_bus          ),
        .if_to_id_bus    (if_to_id_bus    ),
        .inst_sram_en    (inst_sram_en    ),
        .inst_sram_wen   (inst_sram_wen   ),
        .inst_sram_addr  (inst_sram_addr  ),
        .inst_sram_wdata (inst_sram_wdata )
    );

    ID u_ID(
    	.clk             (clk             ),
        .rst             (rst             ),
        .stall           (stall           ),
        .stallreq        (stallreq        ),
        .if_to_id_bus    (if_to_id_bus    ),
        .inst_sram_rdata (inst_sram_rdata ),
        .wb_to_rf_bus    (wb_to_rf_bus    ),
        .ex_to_rf_bus    (ex_to_rf_bus    ),
        .mem_to_rf_bus   (mem_to_rf_bus   ),
        .id_to_ex_bus    (id_to_ex_bus    ),
        .br_bus          (br_bus          ),
        .pre_inst_is_load (pre_inst_is_load),
        .id_load_bus     (id_load_bus     ),
        .id_save_bus     (id_save_bus     ),
        .id_hilo_bus     (id_hilo_bus     ),
        .ex_hilo_bus     (ex_hilo_bus     )
    );

    EX u_EX(
    	.clk             (clk             ),
        .rst             (rst             ),
        .stall           (stall           ),
        .stallreq_for_ex (stallreq_for_ex ),
        .id_to_ex_bus    (id_to_ex_bus    ),
        .id_load_bus     (id_load_bus     ),
        .id_save_bus     (id_save_bus     ),
        .ex_to_mem_bus   (ex_to_mem_bus   ),
        .ex_to_rf_bus    (ex_to_rf_bus    ),
        .data_ram_sel    (data_ram_sel    ),
        .data_sram_en    (data_sram_en    ),
        .data_sram_wen   (data_sram_wen   ),
        .data_sram_addr  (data_sram_addr  ),
        .data_sram_wdata (data_sram_wdata ),
        .ex_load_bus     (ex_load_bus     ),
        .pre_inst_is_load (pre_inst_is_load),
        .id_hilo_bus     (id_hilo_bus     ),
        .ex_hilo_bus     (ex_hilo_bus     )
    );

    MEM u_MEM(
    	.clk             (clk             ),
        .rst             (rst             ),
        .stall           (stall           ),
        .ex_to_mem_bus   (ex_to_mem_bus   ),
        .data_ram_sel    (data_ram_sel    ),
        .data_sram_rdata (data_sram_rdata ),
        .ex_load_bus     (ex_load_bus     ),
        .mem_to_wb_bus   (mem_to_wb_bus   ),
        .mem_to_rf_bus   (mem_to_rf_bus   )
    );
    
    WB u_WB(
    	.clk               (clk               ),
        .rst               (rst               ),
        .stall             (stall             ),
        .mem_to_wb_bus     (mem_to_wb_bus     ),
        .wb_to_rf_bus      (wb_to_rf_bus      ),
        .debug_wb_pc       (debug_wb_pc       ),
        .debug_wb_rf_wen   (debug_wb_rf_wen   ),
        .debug_wb_rf_wnum  (debug_wb_rf_wnum  ),
        .debug_wb_rf_wdata (debug_wb_rf_wdata )
    );

    CTRL u_CTRL(
    	.rst   (rst   ),
    	.stallreq_for_load (stallreq),
    	.stallreq_for_ex   (stallreq_for_ex),
        .stall (stall )
    );
    
endmodule