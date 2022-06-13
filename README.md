
# A dead simple moneybag script

A quick way to add moneybags as an item into qb-core
## Usage/Examples

`/moneybag 200` will make a bag item with $200 in it. 

It's just a regular usable item to turn back into cash.


## FAQ

#### Isn't this code already in the framework as seized cash?

Yes. I've just made it accessable to all players. Not just police.

#### Wouldn't this make cash subject to duplication glitches?

Yes. Duplication glitches that work on items will work on this. Use at your own risk.


## Environment Variables

To run this project, you will need to add the following to your qb-inventory>html>js>app.js

```
        else if (itemData.name == "money_bag") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html(
                "<p><strong>Amount of cash: </strong><span>$" +
                itemData.info.cash +
                "</span></p>" + "<p><strong>User: </strong><span>$" +
                itemData.info.user +
                "</span></p>"
            );
        }
```
