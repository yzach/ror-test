ActiveAdmin.register Complaint do

  permit_params :user_id, :original_text, :suggested_text, :status
  
end
