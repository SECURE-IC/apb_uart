--
-- Input synchronization
--
-- Author:   Sebastian Witt
-- Data:     27.01.2008
-- Version:  1.0
--
-- This code is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
--
-- This code is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library; if not, write to the
-- Free Software  Foundation, Inc., 59 Temple Place, Suite 330,
-- Boston, MA  02111-1307  USA
--

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

library macro_cell_lib;
use macro_cell_lib.all;

entity slib_input_sync is
    port (
        CLK         : in std_logic;     -- Clock
        RST         : in std_logic;     -- Reset
        D           : in std_logic;     -- Signal input
        Q           : out std_logic     -- Signal output
    );
end slib_input_sync;

architecture rtl of slib_input_sync is

    component sic_cell_resync is
    generic (
        g_pure_b2b_ff : boolean   := true;
        g_use_srst	  : boolean   := false;
        g_use_arst	  : boolean   := true;
        g_srst_level  : boolean   := false;
        g_arst_level  : boolean   := false;
        g_reset_value : boolean   := false
        );
    port (
        aRst : in  std_logic;
        sRst : in  std_logic;
        clk	 : in  std_logic;
        din	 : in  std_logic;
        dout : out std_logic
        );
    end component sic_cell_resync;

begin

    resync_cell: sic_cell_resync
    generic map (
        g_pure_b2b_ff => true,
        g_use_srst    => false,
        g_use_arst    => true,
        g_arst_level  => true,
        g_reset_value => false
    ) port map (
        aRst => RST,
        sRst => '0',
        clk  => CLK,
        din  => D,
        dout => Q
    );

end rtl;

