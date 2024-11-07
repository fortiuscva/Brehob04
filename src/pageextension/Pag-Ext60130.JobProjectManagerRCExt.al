pageextension 60130 "Job Project Manager RC Ext" extends "Job Project Manager RC"
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
