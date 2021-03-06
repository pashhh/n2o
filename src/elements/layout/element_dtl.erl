-module(element_dtl).
-author('Maxim Sokhatsky').
-include_lib("n2o/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, dtl).

render_element(Record) ->
    File = wf:to_list(Record#dtl.file),
    render_template(code:lib_dir(Record#dtl.app) ++ "/" ++ Record#dtl.folder ++ "/" ++ File, File,
                    Record#dtl.bindings ++ [{script,get(script)}]).

render_template(FullPathToFile,ViewFile,Data) ->
    Pieces = string:tokens(ViewFile,"/"),
    Name = string:join(Pieces,"_"),
%    error_logger:info_msg("File: ~p", [FullPathToFile]),
%    error_logger:info_msg("File: ~p", [Name]),
    Name1 = filename:basename(Name,".html"),
    ModName = list_to_atom(Name1 ++ "_view"),
%    error_logger:info_msg("Module: ~p", [ModName]),
    erlydtl:compile(FullPathToFile,ModName),
    {ok,Render} = ModName:render(Data),
%    error_logger:info_msg("DTL: ~p", [Render]),
    iolist_to_binary(Render).
