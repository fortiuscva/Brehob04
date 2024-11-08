pageextension 60127 "Acc. Receivables Adm. RC Ext" extends "Acc. Receivables Adm. RC"
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
