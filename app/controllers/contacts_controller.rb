class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create_table
    end
end