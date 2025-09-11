<Entrenchments>
{
for $entr in doc("MapInfo.xdb")/MapInfo/Entrenchments/Item/sections/Item/data/Item,
    $obj in doc("MapInfo.xdb")/MapInfo/Objects/Item[ data(Link/LinkID) = data($entr) ]
(: return element Object { $obj/Object/@href } :)
order by xs:integer($obj/FrameIndex)
return $obj
}
</Entrenchments>