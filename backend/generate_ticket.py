from itertools import combinations
import random


def gen_ticket():
    comb = list(combinations([1,2,3,4,5,6,7,8,9],5))
    myList = []
    numberList = [i for i in range(10)]
    while True:
        myList = []
        numberList = [i for i in range(1,10)]
        for i in range(3):
            x = random.choice(comb)
            if x not in myList:
                for each_number in x:
                    if each_number in numberList:
                        numberList.remove(each_number)
                myList.append(x)
        # print(myList)
        # print(numberList)
        if not numberList:
            break
    # print(myList)
    ticketLayout = []
    finalCount = [0 for i in range(0,9)]
    for each_row in myList:
        ticket = [0,0,0,0]
        for each_number in each_row:
            ticket.insert(each_number-1,1)
            finalCount[each_number-1] += 1
        # print(ticket)
        ticketLayout.append(ticket)
    # print(finalCount)
    # print(ticketLayout)
    counter = 0
    myTicket = []
    for i in range(0,90,10):
        counter1 = finalCount[counter]
        while counter1 > 0:
            x = random.randint(i+1,i+10)
            # print(x)
            if x not in myTicket:
                myTicket.append(x)
                counter1 -= 1
        counter += 1
    myTicket.sort()
    # print(myTicket)
    myTicketNumbers = myTicket.copy()
    for i in range(9):
        for j in range(3):
            if ticketLayout[j][i] == 1:
                ticketLayout[j][i] = myTicket[0]
                myTicket.remove(myTicket[0])
    return {
        'ticket':myTicketNumbers,
        'layout':ticketLayout
    }

    # for each in ticketLayout:
    #     print(each)

# print(gen_ticket())

def gen_bulk_tickets(numberOfTickets):
    myTicketNumbers = []
    myTicketLayouts = []
    counter = 0
    while True:
        x = gen_ticket()
        if x['ticket'] not in myTicketNumbers:
            myTicketNumbers.append(x['ticket'])
            myTicketLayouts.append(x['layout'])
            counter +=1
        if counter == numberOfTickets:
            break
    return myTicketLayouts


