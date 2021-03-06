-module(element_email_link).
-compile('Rusty Klophaus').
-include_lib("n2o/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, email_link).

render_element(Rec = #email_link{}) -> 
    Email = Rec#email_link.email,
    Text = if
        Rec#email_link.text == [] andalso Rec#email_link.body == [] ->
            wf:html_encode(Email);
        true -> Rec#email_link.text
    end,

    #link{
        id=Rec#email_link.id,
        class=Rec#email_link.class,
        title=Rec#email_link.title,
        text=Text,
        body=Rec#email_link.body,
        new=false,
        html_encode=Rec#email_link.html_encode,
        url=["mailto:",Email]
    }.
