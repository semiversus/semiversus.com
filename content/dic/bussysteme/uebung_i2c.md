title: I&sup2;C Übungsaufgaben
parent: i2c.md

# Aufgabe ADXL345
In dieser Übung wird der Beschleunigungssensor [ADXL345](http://www.analog.com/en/products/mems/mems-accelerometers/adxl345.html){: class="external" } von [Analog Devices](http://www.analog.com/){: class="external" } angesteuert. Die angaben stammen aus dem entsprechenden [Datenblatt](http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf){: class="download" }.

Die 7-Bit Adresse des Bausteins wird für diese Übung mit <samp>001 1101</samp> (0x1D) angenommen.

## Register
Der Baustein verfügt intern über mehrere Register. Jeder Register ist ein Byte groß.
<figure><img src="{filename}adxl345_registers.svg"><figcaption>Registerübersicht (Bild: <a href="http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf">Datenblatt ADXL345</a> &copy;Analog Devices)</figcaption></figure>

In der folgenden Abbildung sieht man insgesamt vier Übertragungsarten:

* Schreiben eines Bytes in ein Register
* Schreiben mehrerer Byte in mehrere Register
* Lesen eines Bytes aus einem Register
* Lesen mehrere Bytes aus mehreren Registern

<figure><img src="{filename}adxl345_overview.svg"><figcaption>Lesen und Schreiben einzelner sowie mehrer Bytes (Bild: <a href="http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf">Datenblatt ADXL345</a> &copy;Analog Devices)</figcaption></figure>
Hinweise zum Bild:

1. Dieses *START* ist entweder ein *repeated START* oder ein *STOP* mit anschließendem *START*
2. Der graue schattierte Bereich markiert die Phasen, in denen die entsprechende Komponente den Buszustand beobachtet

## Beispiel

Beschreiben des Registers <code>OFSX</code> (0x1E) mit dem Wert 0x02:

![Schreibe 0x02 auf das Register 0x1E]({filename}i2c_write_0x1E_0x02.svg)

Lesen der Register <code>THRES_ACT</code> und <code>THRES_INACT</code> (0x24 und 0x25)

![Lesen der Register 0x24 und 0x25]({filename}i2c_read_0x24.svg)

## Aufgabenstellung
Skizziere folgende Übertragungen am I&sup2;C Bus:

* Beschreiben des Registers <code>DUR</code> mit dem Wert <samp>0x05</samp>
* Bechreiben der Registers <code>OFSX</code>, <code>OFSY</code>, <code>OFSZ</code> mit den  Werten <samp>[0x17, 0x2A, 0x04]</samp> (mit nur einem Zugriff)
* Lesen des Registers <code>ACT_TAP_STATUS</code> (angenommener Inhalt ist <samp>0x10</samp>)
* Lesen der Register <code>DATAX0</code> bis <code>DATAY1</code> (angenommener Inhalt ist <samp>[0x08, 0xE3, 0x01, 0xA7]</samp>, mit nur einem Zugriff)
