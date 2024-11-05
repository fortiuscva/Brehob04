pageextension 60131 "Whse. Basic Role Center Ext" extends "Whse. Basic Role Center"
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
