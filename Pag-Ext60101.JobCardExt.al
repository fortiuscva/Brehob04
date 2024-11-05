pageextension 60101 "Job Card Ext" extends "Job Card"
{
    layout
    {
        addafter("Ship-to Contact")
        {
        //field("Location Code"; rec."Location Code")
        //{
        //    ApplicationArea = All;
        //    ToolTip = 'Specifies the value of the Location Code field.';
        //}
        }
        addafter("Project Manager")
        {
            group("Work Description")
            {
                Caption = 'Work Description';

                field(WorkDescription; WorkDescription)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Describes the purpose of the job.';

                    trigger OnValidate()
                    begin
                        rec.SetWorkDescription(WorkDescription);
                    end;
                }
            }
        }
        addbefore("Work Description")
        {
            field("Ready To Invoice"; rec."Ready To Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if the job is ready to invoice.';
            }
            field("Priority Level"; rec."Priority Level")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if the job is Urgent, Important or Standard.';
            }
            field("Field Service"; rec."Field Service")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if the job is for field service work.';
            }
        }
        addbefore("External Document No.")
        {
            field("P.O. Required"; Rec."P.O. Required")
            {
                ApplicationArea = all;
                Caption = 'P.O. Required';
                ToolTip = 'If checked, a purchase order is required from the customer.';
            }
        }
        addbefore(Blocked)
        {
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = all;
                Caption = 'Salesperson Code';
                ToolTip = 'If checked, a purchase order is required from the customer.';
            }
        }
        addafter("Creation Date")
        {
            field("Completion Date"; rec."Completion Date")
            {
                ApplicationArea = all;
                Caption = 'Completion Date';
                ToolTip = 'This is the maximum Ending Date of the associated tasks.';
            }
        }
    }
    var WorkDescription: Text;
    trigger OnAfterGetRecord()
    begin
        WorkDescription:=rec.GetWorkDescription();
    end;
}
