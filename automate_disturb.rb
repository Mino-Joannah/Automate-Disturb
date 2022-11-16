# Team's members :
# ESIIA3_N°11_RAKOTONOELINA Lala Minoniaina Joannah  
# ESIIA3_N°12_RANDRIANATOANDRO Miangoty Daniellah  
class AutomateDisturb 
    attr_reader :balance
        @@do = { 1 => "Cash Withdrawal", 2 => "Other Service : Verify Balance"}
        @@sum = { 1 => 50000, 2 => 100000, 3 => 200000, 4 => 300000, 5 => "Other sum", 6 => @@do[2], 7 => "Interrupt the current operation"}
        @@methods = { 1 => "Minimum ticket", 2 => "Balance ticket", 3 => "Change Sum", 4 => "Interrupt the current operation"}
        @@ticket = [20000, 10000, 5000]
        @@quit = { 1 => "Yes", 2 => "NO"}

    def initialize 
        @balance = 10000000
        p "------ WELCOME ------"
        to_do
    end

    private 
    def to_do
        p "What do you want to do?"
        @@do.each do |k, v| 
            p "#{k}- #{v}"
        end
        begin
            p "Please, enter your choice :"
            c = gets.chomp.to_i
        end while (c < 1 || c > 2)
        if c == 1 
            choice
        else get_balance end
    end

    def choice
        p "----- CASH WITHDRAWAL -----"
        @@sum.each do |k, v| 
            p "#{k}- #{v} #{ (v.is_a? Fixnum) ? 'Ar' : ''}"
        end
        begin
            p "Please, enter your choice :"
            c = gets.chomp.to_i
        end while (c < 1 || c > 7)
        case c
            when 1, 2, 3, 4 
                if(@balance < @@sum[c])
                    p "Sorry, insufficient balance"
                    quit
                else cash_withdrawal_method(@@sum[c]) end
            when 5
                other_sum
            when 6
                get_balance
            when 7
                quit
        end
    end

    def other_sum
        p " Enter another sum :"
        begin
            p "enter the sum (the minimum is #{@@sum[1]}) :"
            c = gets.chomp.to_i
            p "We can't give a ticket less than #{@@ticket[2]}Ar" if (c % @@ticket[2] != 0)
        end while (c < @@sum[1] || c % @@ticket[2] != 0)
        if(@balance < c)
            p "Sorry, insufficient balance"
            quit
        else cash_withdrawal_method(c) end
    end

    def get_balance
        p "---- BALANCE ----"
        p "You have #{@balance} Ar"
        quit
    end

    def cash_withdrawal_method(cash)
        p "What method do you prefer ?"
        @@methods.each do |k, v| 
            p "#{k}- #{v}"
        end

        begin
            p "Please, enter your choice :"
            c = gets.chomp.to_i
        end while (c < 1 || c > 4)
        case c 
            when 1
                min_ticket(cash)
            when 2
                balance_ticket(cash)
            when 3
                choice
            when 4
                quit
        end
    end

    def cash_withdrawal(sum)
        @balance -= sum
    end

    def min_ticket(cash)
        p "---- CASH WITHDRAWAL Minimum ticket----" 
        ticket = {}
        cash_withdrawal(cash)
        div =  @@ticket[0]
        while( cash != 0)
            ticket[div] = (cash / div).to_i
            cash -= ticket[div] * div
            div /= 2
        end
        show_ticket(ticket)
    end

    def balance_ticket(cash)
        p "---- CASH WITHDRAWAL Balance ticket----" 
        n1 = 0; n2 = 0; n3 = 0; 
        cash_withdrawal(cash)
        while cash > 0
            unless cash < @@ticket[0]
                cash -= @@ticket[0]
                n1 += 1
                break if cash == 0 
            end
            unless cash < @@ticket[1]
                cash -= @@ticket[1] 
                n2 += 1
                break if cash == 0
            end
            unless cash < @@ticket[2]
                cash -= @@ticket[2]
                n3 += 1
            end
        end
        ticket = {@@ticket[0] => n1, @@ticket[1] => n2, @@ticket[2] => n3}
        show_ticket(ticket)
    end

    def show_ticket(ticket)
        p "You get :"
        ticket.each do |k, v|
            p "#{k}Ar * #{v}"
        end
        quit
    end
    
    def quit
        p "Do you want to quit"
        @@quit.each do |k, v|
            p "#{k}- #{v}"
        end

        begin
            p "Your choice"
            c = gets.chomp.to_i
        end while(c < 1 || c > 2)

        if c == 1
            p "--- Thank You --- See You ---"
        else to_do end
    end
end
automate_disturb = AutomateDisturb.new