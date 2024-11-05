pageextension 60102 "Jobs Setup Ext" extends "Jobs Setup"
{
    layout
    {
        addafter("Document No. Is Job No.")
        {
            field("Default Job No."; rec."Default Job No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Job No. is the Sales Order No. or the next available Job No.';
            }
            field("Default Task No."; rec."Default Task No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Task No. field.';
            }
            field("Default Job Status"; rec."Default Job Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Job Status field.';
            }
        }
    }
}
