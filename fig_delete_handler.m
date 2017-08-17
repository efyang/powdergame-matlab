function fig_delete_handler( ~, ~ )
%FIG_DELETE_HANDLER handles when the window is closed
global program_continue
program_continue = false;
end

