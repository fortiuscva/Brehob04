pageextension 60128 "Purch. Agent Role Center Ext" extends "Purchasing Agent Role Center"
{
    layout
    {
        addafter("User Tasks Activities")
        {
            part("Approvals Activities"; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }
}
