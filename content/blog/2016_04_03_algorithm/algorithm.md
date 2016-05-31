title: Algorithmus zur Belegung der Sitzplätze
date: 2016-04-03
tags: Programmieren

Bei jeder Konferenz das gleiche Bild: Kurz vor dem Start eines Vortrags wird deutlich darauf hingewiesen, dass niemand
stehen müsste, wenn alle Plätze in den Reihen gefüllt würden. Teilweise gibt es große Lücken und man fragt sich wieso.

Das Problem ist ein menschliches - viele Teilnehmende sind bereits länger hier und fanden einen quasi freien Raum vor und
da setzt man sich eben irgendwo hin. So langsam füllt sich der Raum, da aber das eigene Notebook, Getränke und der Snack
zwischendurch bereits ausgebreitet wurden ist ein Platzwechsel sehr mühsam.

Für Softwarekonferenzen habe ich folgenden Algorithmus zur Platzvergabe entwickelt. Solange alle diesem Algorithmus bei
der Platzsuche folgen werden die verfügbare Sitzplätze optimal ausgenutzt.

    #!python
    class PythonesqueHuman(Human):
        def find_seat(self, room):
            for row in room.rows:
                if row[0].isSeatFree():
                    seat_index=0
                elif row[-1].isSeatFree():
                    seat_index=len(row)-1
                else:
                    continue

                self.takeSeat(row, seat_index)

                direction=1 if seat_index<len(row)/2 else -1

                while row[seat_index+direction].isSeatFree() and seat_index!=int(len(row)/2):
                    seat_index+=direction
                    self.takeSeat(row, seat_index)

                return
                     
            raise EnvironmentError("No seat left in this room") 
