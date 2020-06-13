from PIL import Image,ImageDraw,ImageFont
import random
from generate_ticket import gen_bulk_tickets
from io import BytesIO
import base64

# numbers = [1,11,21,31,41,51,61,71,81]
# numbers = [1]


# ticketLayout = [[1, 14, 0, 33, 0, 58, 0, 73, 0],
# [0, 16, 21, 0, 42, 0, 0, 78, 84],
# [9, 0, 30, 36, 0, 60, 61, 0, 0]]


# cordinates = [66,67]
# cordinates = [[69, 72], [143, 71], [219, 70], [292, 70], [363, 69], [434, 70], [511, 70], [582, 72], [659, 71]]
cordinates = [[66, 68], [141, 68], [213, 69], [286, 68], [362, 69], [429, 69], [504, 70], [577, 68], [647, 71], [67, 128], [137, 128], [211, 127], [287, 127], [356, 128], [431, 127], [501, 126], [578, 126], [651, 128], [65, 185], [137, 185], [209, 184], [283, 184], [357, 185], [429, 184], [505, 185], [575, 184], [647, 184]]
box_cordinates = [[53, 57], [123, 116], [125, 57], [196, 115], [196, 58], [270, 115], [270, 57], [342, 114], [341, 57], [414, 114], [416, 58], [487, 116], [488, 57], [561, 115], [559, 56], [633, 115], [634, 58], [705, 115], [53, 117], [124, 175], [124, 116], [197, 175], [197, 115], [270, 175], [268, 117], [342, 174], [343, 116], [416, 174], [414, 116], [488, 174], [489, 116], [561, 174], [561, 116], [634, 174], [634, 116], [706, 173], [53, 176], [124, 231], [124, 174], [196, 233], [197, 175], [269, 234], [269, 176], [343, 233], [342, 175], [416, 234], [414, 176], [489, 234], [486, 175], [561, 233], [561, 175], [633, 234], [633, 174], [706, 232], [707, 176]]
ticket_number_cordintes = [580,22]
row_cord = [71,127,184]



def generate_housie_images(numberOfImages):
    myTickets = gen_bulk_tickets(numberOfImages)
    # print(myTickets)
    ticket_counter = 1
    listOfTickets = []



    for eachTicket in myTickets:
        imagesToBase64Strings = {}
        counter = 0
        image = Image.open(r"/home/jarvis/Python/Bingo/BingoTickets/housie_ticket.jpg")
        draw = ImageDraw.Draw(image)
        font = ImageFont.truetype(r"dorisbr.ttf",size=30,encoding="UTF-8")
        draw.text(tuple(ticket_number_cordintes),str(ticket_counter).zfill(3),fill=(0,0,0),font=font)
        for each_row,row_cordinates in zip(eachTicket,row_cord):
            for row_numbers in each_row:
                if row_numbers != 0:
                    font = ImageFont.truetype(r'dorisbr.ttf',size=35,encoding="UTF-8")
                    draw.text((cordinates[counter][0],row_cordinates),str(row_numbers),fill=(0,0,0),font=font)
                # cordinates[0] += 80
                # else:
                #     draw.rectangle([tuple(box_cordinates[counter*2]),tuple(box_cordinates[(counter*2)+1])],fill=(18,229,239))
                counter += 1

        output = BytesIO()
        file_path = r"./HousieTickets" + r"/housie_test_" + str(ticket_counter) + ".png"
        image.save(file_path)
        image.save(output,format="JPEG")
        im_data = output.getvalue()
        # print(im_data)
        image_data = base64.b64encode(im_data)
        imagesToBase64Strings['ticket_num'] = ticket_counter
        imagesToBase64Strings['img'] = image_data.decode("utf-8")
        imagesToBase64Strings['row_1'] = eachTicket[0]
        imagesToBase64Strings['row_2'] = eachTicket[1]
        imagesToBase64Strings['row_3'] = eachTicket[2]
        listOfTickets.append(imagesToBase64Strings)
        ticket_counter += 1
    # print(listOfTickets[1]['row_1'])
    return listOfTickets


# print(generate_housie_images(2))

