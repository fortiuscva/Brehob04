pageextension 60105 "Posted Sales Invoice Ext" extends "Posted Sales Invoice"
{
    layout
    {
        addafter(Closed)
        {
            field("Job Required"; rec."Job Required")
            {
                applicationarea = all;
            }
            field("Job No."; rec."Job No.")
            {
                applicationarea = all;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Job No.");
    end;
}
