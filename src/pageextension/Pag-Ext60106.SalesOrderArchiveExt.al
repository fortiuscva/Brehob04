pageextension 60106 "Sales Order Archive Ext" extends "Sales Order Archive"
{
    layout
    {
        addafter(Status)
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
}
