cat << EOF > /tmp/reqpm.xml
<?xml version='1.0' encoding='UTF-8'?>
<feed xmlns="http://www.w3.org/2005/Atom"
      xmlns:batch="http://schemas.google.com/gdata/batch"
      xmlns:gs="http://schemas.google.com/spreadsheets/2006">
  <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/batch</id>
  <entry>
    <batch:id>A1</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C3</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C3/version"/>
    <gs:cell row="$row2" col="3" inputValue="=MIN(F${row2},H${row2},J${row2},L${row2},N${row2})"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C4</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C4/version"/>
    <gs:cell row="$row2" col="4" inputValue="=MAX(F${row2},H${row2},J${row2},L${row2},N${row2})"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C5</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C5/version"/>
    <gs:cell row="$row2" col="5" inputValue="$northPSI"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C6</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C6/version"/>
    <gs:cell row="$row2" col="6" inputValue="$northPM"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C7</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C7/version"/>
    <gs:cell row="$row2" col="7" inputValue="$southPSI"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C8</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C8/version"/>
    <gs:cell row="$row2" col="8" inputValue="$southPM"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C9</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C9/version"/>
    <gs:cell row="$row2" col="9" inputValue="$eastPSI"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C10</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C10/version"/>
    <gs:cell row="$row2" col="10" inputValue="$eastPM"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C11</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C11/version"/>
    <gs:cell row="$row2" col="11" inputValue="$westPSI"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C12</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C12/version"/>
    <gs:cell row="$row2" col="12" inputValue="$westPM"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C13</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C13/version"/>
    <gs:cell row="$row2" col="13" inputValue="$centralPSI"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C14</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C14/version"/>
    <gs:cell row="$row2" col="14" inputValue="$centralPM"/>
  </entry>
</feed>
EOF
## send xml
curl -L --silent --request POST --header "Authorization: GoogleLogin auth=${token}" "https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/batch?v=3.0" --header "Content-Type: application/atom+xml" --header "If-Match: *" --data-binary "@/tmp/reqpm.xml"
rm /tmp/reqpm.xml

