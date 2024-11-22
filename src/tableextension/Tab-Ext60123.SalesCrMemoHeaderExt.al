tableextension 60123 "Sales Cr.Memo Header Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(60100; "Job No."; Code[20])
        {
            Caption = 'Project No.';
            Editable = false;
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Line"."Job No." where("Document No."=field("No."), "Job No."=filter(<>'')));
        }
    }
}
