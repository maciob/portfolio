#!/bin/bash

# INPUT SOME VALUES

response="$(curl -s -d '{"Author":"newAuthor1","Title":"newTitle1","Year":"1993"}' -H "Content-Type: application/json" -X POST http://backend:5000/api | cut -d ':' -f2 | cut -d '}' -f1)"
if [[ "$response" -eq "200" ]]
    then
        echo "test of putting first book passed"
    else
        echo "test of putting first book failed"
        exit 1
fi

response="$(curl -s -d '{"Author":"newAuthor2","Title":"newTitle2","Year":"1994"}' -H "Content-Type: application/json" -X POST http://backend:5000/api | cut -d ':' -f2 | cut -d '}' -f1)"
if [[ "$response" -eq "200" ]]
    then
        echo "test of putting second book passed"
    else
        echo "test of putting second book failed"
        exit 1
fi

response="$(curl -s -d '{"Author":"newAuthor3","Title":"newTitle3","Year":"1995"}' -H "Content-Type: application/json" -X POST http://backend:5000/api | cut -d ':' -f2 | cut -d '}' -f1)"
if [[ "$response" -eq "200" ]]
    then
        echo "test of putting third book passed"
    else
        echo "test of putting third book failed"
        exit 1
fi

response="$(curl -s -d '{"Author":"newAuthor4","Title":"newTitle4","Year":"1996"}' -H "Content-Type: application/json" -X POST http://backend:5000/api | cut -d ':' -f2 | cut -d '}' -f1)"
if [[ "$response" -eq "200" ]]
    then
        echo "test of putting fourth book passed"
    else
        echo "test of putting fourth book failed"
        exit 1
fi

response="$(curl -s -d '{"Author":"newAuthor5","Title":"newTitle5","Year":"1997"}' -H "Content-Type: application/json" -X POST http://backend:5000/api | cut -d ':' -f2 | cut -d '}' -f1)"
if [[ "$response" -eq "200" ]]
    then
        echo "test of putting fifth book passed"
    else
        echo "test of putting fifth book failed"
        exit 1
fi

# CHECK IF THE VALUES ARE THERE

response="$(curl -i -s -X GET http://backend:5000/api | grep 200 | cut -d ' ' -f2)"
if [[ "$response" -eq "200" ]]
    then
        echo "test of checking if all values exists passed"
    else
        echo "test of checking if all values exists failed"
        exit 1
fi

# CREATE LIST OF IDS

list=()
count=1
while true
do
    output_id=$(curl -s -X GET http://backend:5000/api | cut -d '}' -f$count | cut -d ':' -f2 | cut -d ',' -f1 | tail -c +3 | head -c -2 )
    
    if [[ -z "${output_id// }" ]]; then
        break
    else
        list+=($output_id)
    fi
    ((count=count+1))
done

# CHECK THE VALUES OF THIRD BOOK

response=$(curl -s -i -X GET http://backend:5000/api/${list[2]} | grep 200 | cut -d ' ' -f2 )
if [[ "$response" -eq "200" ]]
    then
        echo "test of GETTING value of single book ${list[2]} passed"
    else
        echo "test of GETTING value of single book ${list[2]} failed"
        exit 1
fi

# EDIT THIRD BOOK 

response="$(curl -s -d '{"Author":"editedAuthor","Title":"editedTitle","Year":"2022"}' -H "Content-Type: application/json" -X PUT http://backend:5000/api/${list[2]} | cut -d ':' -f2 | cut -d '}' -f1)"
if [[ "$response" -eq "200" ]]
    then
        echo "test of EDITING value of single book ${list[2]} passed"
    else
        echo "test of EDITING value of single book ${list[2]} failed"
        exit 1
fi


# CHECK THE VALUES OF THIRD BOOK 

response=$(curl -s -i -X GET http://backend:5000/api/${list[2]} | grep 200 | cut -d ' ' -f2 )
if [[ "$response" -eq "200" ]]
    then
        echo "test of GETTING value of single book ${list[2]} passed"
    else
        echo "test of GETTING value of single book ${list[2]} failed"
        exit 1
fi

# CHECK THE VALUES OF FIRST BOOK

# response=$(curl -s -i -X GET http://backend:5000/api/${list[0]} | grep 200 | cut -d ' ' -f2 )
# if [[ "$response" -eq "200" ]]
#     then
#         echo "test of GETTING value of single book ${list[0]} passed"
#     else
#         echo "test of GETTING value of single book ${list[0]} failed"
# fi

# DELETE THE FIRST BOOK

# response=$(curl -s -i -X DELETE http://backend:5000/api/${list[0]} | grep 200 | cut -d ' ' -f2 )
# if [[ "$response" -eq "200" ]]
#     then
#         echo "test of DELETE value of single book ${list[0]} passed"
#     else
#         echo "test of DELETE value of single book ${list[0]} failed"
# fi

# CHECK IF THE VALUES OF OLD FIRST BOOK ARE THERE

# response="$(curl -X GET http://backend:5000/api/${list[0]})"

# if [[ "$response" -eq "[]" ]]
#     then
#         echo "test of GETTING value of single book ${list[0]} after delete passed"
#     else
#         echo "test of GETTING value of single book ${list[0]} after delete failed"
# fi

# DELETE THE OTHER BOOKS

# unset list[0] 

for x in ${list[@]}
do
    response=$(curl -s -i -X DELETE http://backend:5000/api/$x | grep 200 | cut -d ' ' -f2 )
    if [ $response -eq 200 ]
    then
        echo "test of DELETE value of single book $x passed"
    else
        echo "test of DELETE value of single book $x passed"
        exit 1
    fi
done
