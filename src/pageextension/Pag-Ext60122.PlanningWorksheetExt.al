pageextension 60122 "Planning Worksheet Ext" extends "Planning Worksheet"
{
    layout
    {
        addafter("Ref. Order Status")
        {
            field("Sales Order No."; rec."Sales Order No.")
            {
                caption = 'Sales Order No.';
                ToolTip = 'Specifies the Sales Order No.';
                ApplicationArea = all;
            }
            field("Sales Order Line No."; rec."Sales Order Line No.")
            {
                caption = 'Sales Order Line No.';
                ToolTip = 'Specifies the Sales Order Line No.';
                ApplicationArea = all;
            }
            field("Sales Order Comment"; rec."Sales Order Comment")
            {
                caption = 'Sales Order Comment';
                Tooltip = 'Specifies if a Sales Line Comment exists';
                ApplicationArea = All;
            }
        }
    }
}
