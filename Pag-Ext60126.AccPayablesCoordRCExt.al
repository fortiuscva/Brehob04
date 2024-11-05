pageextension 60126 "Acc. Payables Coord RC Ext" extends "Acc. Payables Coordinator RC"
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
