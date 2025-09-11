xquery version "1.0";
<Objects>
{
	let $sx := xs:integer(doc("MapInfo.xdb")/MapInfo/NumPatchesX) * 16 * 64 - 1
	let $sy := xs:integer(doc("MapInfo.xdb")/MapInfo/NumPatchesY) * 16 * 64 - 1
	for $entr at $pos in doc("MapInfo.xdb")/MapInfo/Objects/Item
		where $entr/Pos/x > $sx or $entr/Pos/y > $sy
		return <Item>{$pos}</Item>
}
</Objects>