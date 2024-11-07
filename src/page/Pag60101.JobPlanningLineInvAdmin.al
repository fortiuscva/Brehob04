page 60101 "Job Planning Line Inv. - Admin"
{
    ApplicationArea = All;
    Caption = 'Project Planning Line Invoice - Administration';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    Permissions = tabledata "Job Planning Line Invoice"=d;
    SourceTable = "Job Planning Line Invoice";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Quantity Transferred"; Rec."Quantity Transferred")
                {
                    ApplicationArea = All;
                }
                field("Transferred Date"; Rec."Transferred Date")
                {
                    ApplicationArea = All;
                }
                field("Invoiced Date"; Rec."Invoiced Date")
                {
                    ApplicationArea = All;
                }
                field("Invoiced Amount (LCY)"; Rec."Invoiced Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Invoiced Cost Amount (LCY)"; Rec."Invoiced Cost Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Job Ledger Entry No."; Rec."Job Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DeleteRecord)
            {
                ApplicationArea = All;
                Caption = 'Delete Record';
                Enabled = DeleteAllowed;
                Image = Delete;

                trigger OnAction()
                var
                    JobPlanningLineInvoice: Record "Job Planning Line Invoice";
                begin
                    CurrPage.SaveRecord();
                    JobPlanningLineInvoice.Get(Rec."Job No.", Rec."Job Task No.", Rec."Job Planning Line No.", Rec."Document Type", Rec."Document No.", Rec."Line No.");
                    JobPlanningLineInvoice.Delete(false);
                    CurrPage.Update();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(DeleteRecord_Promoted; DeleteRecord)
                {
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        DeleteAllowed:=(UserId = 'BCADMIN');
    end;
    var DeleteAllowed: Boolean;
}
