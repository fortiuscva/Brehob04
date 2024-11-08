pageextension 60129 "Accountant Role Center Ext" extends "Accountant Role Center"
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
