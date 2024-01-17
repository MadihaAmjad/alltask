// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;


contract structpract{


struct books{

    string name;
    string auth;
    uint book_id;
}

books[] public b;

function set(string memory bname, string memory bauth, uint b_id) public returns (books memory){


    books memory be= books({

        name:bname,
        auth:bauth,
        book_id:b_id


    });

  b.push(be);
  return be;

}

}