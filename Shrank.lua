﻿
local band, UnitLevel, UnitName, spelllist = bit.band, UnitLevel, UnitName
local reported, spells = {}, setmetatable({}, {
	__index = function(t,i)
		local v = not not spelllist:match(" "..i.." ")
		t[i] = v
		return v
	end
})

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event, timestamp, combatEvent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName)
	if not spells[spellID] or reported[sourceName..spellID] or band(sourceFlags, COMBATLOG_OBJECT_TYPE_MASK) ~= COMBATLOG_OBJECT_TYPE_PLAYER or combatEvent == "SPELL_AURA_REMOVED" or not combatEvent:match("^SPELL") or UnitLevel(sourceName) ~= 80 then return end
	if combatEvent:match("^SPELL_AURA_") then
		if (UnitName("target")) == destName then destName = "target" end
		if destName and UnitLevel(destName) < 80 then return end
	end

	print("Found downranked spell:", GetSpellInfo(spellID), "by", sourceName)
	reported[sourceName..spellID] = true
end)

spelllist = " 10 17 53 78 99 100 116 118 120 122 133 136 139 143 145 168 172 205 284 285 324 325 331 332 339 348 370 403 408 421 465 467 469 527 529 543 547 548 585 587 588 589 591 592 594 596 597 598 600 602 603 604 633 635 639 643 647 686 687 689 693 695 699 702 703 705 706 707 709 710 724 740 755 759 769 772 774 779 780 782 837 845 853 865 879 905 913 915 930 939 943 945 959 970 974 976 980 984 990 992 996 1004 1006 1008 1014 1022 1026 1032 1042 1058 1062 1064 1075 1079 1082 1086 1088 1094 1098 1106 1108 1120 1126 1130 1160 1243 1244 1245 1329 1430 1449 1454 1455 1456 1459 1460 1461 1463 1464 1490 1495 1499 1510 1513 1535 1608 1714 1735 1752 1757 1758 1759 1760 1822 1823 1824 1850 1856 1857 1943 1949 1966 1978 2006 2008 2010 2048 2050 2052 2054 2055 2060 2061 2070 2090 2091 2096 2098 2120 2121 2136 2137 2138 2362 2589 2590 2591 2637 2643 2767 2791 2800 2812 2860 2908 2912 2941 2944 2948 2973 2983 3029 3044 3111 3140 3472 3552 3599 3627 3661 3662 3674 3698 3699 3700 3747 5143 5144 5145 5171 5176 5177 5178 5179 5180 5185 5186 5187 5188 5189 5195 5196 5201 5211 5217 5221 5232 5234 5242 5277 5308 5394 5484 5504 5505 5506 5570 5588 5589 5599 5614 5615 5675 5676 5699 5730 5740 5782 6041 6060 6063 6065 6066 6074 6075 6076 6077 6078 6117 6127 6129 6131 6141 6143 6178 6190 6192 6201 6202 6205 6213 6217 6219 6222 6223 6229 6343 6353 6363 6364 6365 6366 6375 6377 6390 6391 6392 6546 6547 6548 6572 6574 6673 6756 6760 6761 6762 6768 6770 6778 6780 6785 6787 6789 6793 6798 6800 6807 6808 6809 7128 7294 7300 7302 7320 7322 7328 7369 7379 7641 7646 7648 7651 8004 8005 8008 8010 8017 8018 8019 8024 8027 8030 8033 8038 8042 8044 8045 8046 8050 8052 8053 8056 8058 8071 8075 8092 8102 8103 8104 8105 8106 8122 8124 8134 8154 8155 8160 8161 8181 8184 8190 8198 8204 8205 8227 8232 8235 8249 8288 8289 8400 8401 8402 8406 8407 8408 8412 8413 8416 8417 8422 8423 8427 8437 8438 8439 8444 8445 8446 8450 8451 8455 8457 8458 8461 8462 8492 8494 8495 8498 8499 8621 8623 8624 8631 8632 8633 8637 8639 8640 8676 8696 8721 8724 8725 8820 8903 8905 8907 8910 8914 8918 8921 8924 8925 8926 8927 8928 8929 8936 8938 8939 8940 8941 8949 8950 8951 8955 8972 8992 8998 9000 9005 9472 9473 9474 9484 9485 9490 9492 9493 9745 9747 9750 9752 9754 9756 9758 9821 9823 9827 9829 9830 9833 9834 9835 9839 9840 9841 9845 9846 9849 9850 9852 9853 9856 9857 9858 9862 9863 9866 9867 9875 9876 9880 9881 9884 9885 9888 9889 9892 9894 9896 9898 9901 9904 9908 9910 9912 10053 10054 10138 10139 10140 10144 10145 10148 10149 10150 10151 10156 10157 10159 10160 10161 10169 10170 10173 10174 10177 10179 10180 10181 10185 10186 10187 10191 10192 10193 10197 10199 10201 10202 10205 10206 10207 10211 10212 10215 10216 10219 10220 10223 10225 10230 10290 10291 10292 10293 10298 10299 10300 10301 10310 10312 10313 10314 10318 10322 10324 10328 10329 10391 10392 10395 10396 10406 10407 10408 10412 10413 10414 10427 10428 10431 10432 10437 10438 10442 10447 10448 10456 10462 10463 10466 10467 10468 10472 10473 10478 10479 10486 10495 10496 10497 10526 10537 10538 10585 10586 10587 10595 10600 10601 10605 10622 10623 10880 10881 10888 10892 10893 10894 10898 10899 10900 10901 10915 10916 10917 10927 10928 10929 10933 10934 10937 10938 10945 10946 10947 10951 10952 10957 10958 10960 10961 10963 10964 10965 11113 11267 11268 11269 11273 11274 11275 11279 11280 11281 11289 11290 11293 11294 11297 11299 11300 11303 11314 11315 11366 11426 11549 11550 11551 11554 11555 11556 11564 11565 11566 11567 11572 11573 11574 11580 11581 11600 11601 11604 11605 11608 11609 11659 11660 11661 11665 11667 11668 11671 11672 11675 11677 11678 11683 11684 11687 11688 11689 11693 11694 11695 11699 11700 11707 11708 11711 11712 11713 11721 11722 11725 11726 11729 11730 11733 11734 11735 11739 11740 12294 12505 12522 12523 12524 12525 12526 12824 12825 13018 13019 13020 13021 13031 13032 13033 13165 13542 13543 13544 13549 13550 13551 13552 13553 13554 13555 13795 13813 14260 14261 14262 14263 14264 14265 14266 14269 14270 14271 14281 14282 14283 14284 14285 14286 14287 14288 14289 14290 14294 14295 14302 14303 14304 14305 14310 14316 14317 14318 14319 14320 14321 14322 14323 14324 14325 14326 14752 14818 14819 14914 15207 15208 15237 15261 15262 15263 15264 15265 15266 15267 15407 15430 15431 16339 16341 16342 16355 16356 16362 16387 16511 16689 16810 16811 16812 16813 16914 17311 17312 17313 17314 17329 17347 17348 17401 17402 17727 17728 17877 17919 17920 17921 17922 17923 17924 17925 17926 17951 17952 17953 18220 18657 18807 18809 18867 18868 18869 18870 18871 18937 18938 19236 19238 19240 19241 19242 19243 19276 19277 19278 19279 19280 19306 19386 19434 19740 19742 19750 19834 19835 19836 19837 19838 19850 19852 19853 19854 19876 19888 19891 19895 19896 19897 19898 19899 19900 19939 19940 19941 19942 19943 20043 20116 20190 20243 20473 20484 20569 20609 20610 20658 20660 20661 20662 20739 20742 20747 20748 20752 20755 20756 20757 20770 20772 20773 20776 20777 20900 20901 20902 20903 20904 20909 20910 20922 20923 20924 20925 20927 20928 20929 20930 21551 21552 21553 21562 21564 21849 21850 22568 22570 22782 22783 22827 22828 22829 23028 23922 23923 23924 23925 24132 24133 24239 24248 24274 24275 24398 24974 24975 24976 24977 25202 25203 25208 25210 25213 25217 25218 25221 25222 25231 25233 25234 25235 25236 25241 25242 25248 25258 25264 25269 25286 25288 25289 25290 25291 25292 25294 25295 25296 25297 25298 25299 25300 25302 25304 25306 25307 25308 25309 25311 25312 25314 25315 25316 25331 25345 25357 25361 25363 25364 25367 25368 25372 25375 25384 25387 25389 25391 25392 25396 25420 25422 25423 25431 25433 25435 25437 25439 25442 25448 25449 25454 25457 25464 25467 25469 25472 25489 25500 25505 25508 25509 25525 25528 25533 25546 25547 25552 25557 25560 25563 25567 25570 25574 25590 25782 25894 25916 25918 26573 26679 26839 26861 26862 26863 26864 26865 26867 26884 26978 26979 26980 26981 26982 26983 26984 26985 26986 26987 26988 26989 26990 26991 26992 26994 26996 26997 26998 27000 27001 27002 27003 27004 27005 27006 27008 27009 27012 27013 27014 27016 27019 27021 27022 27023 27025 27045 27046 27065 27067 27068 27070 27071 27072 27073 27074 27075 27078 27079 27080 27082 27085 27086 27087 27088 27101 27124 27125 27126 27127 27128 27130 27131 27132 27133 27134 27135 27136 27137 27138 27139 27140 27141 27142 27143 27149 27150 27151 27152 27153 27154 27173 27174 27179 27180 27209 27210 27211 27212 27213 27215 27216 27217 27218 27219 27220 27222 27223 27224 27228 27230 27238 27243 27250 27259 27260 27263 27265 27441 27448 27681 27683 27799 27800 27801 27841 27870 27871 28172 28176 28189 28275 28609 28610 28612 29228 29707 29722 29893 30016 30022 30108 30283 30324 30330 30356 30357 30404 30405 30413 30414 30451 30455 30459 30482 30545 30546 30706 30909 30910 31016 31018 31661 31709 31935 32231 32379 32546 32593 32594 32645 32684 32699 32700 32796 32996 32999 33041 33042 33043 33072 33076 33405 33736 33745 33763 33876 33878 33933 33938 33944 33946 33982 33983 33986 33987 34120 34411 34412 34413 34861 34863 34864 34865 34866 34914 34916 34917 36916 37420 38692 38697 38699 38704 39374 42832 42841 42843 42858 42872 42890 42894 42896 42913 42920 42925 42930 42939 42944 42949 42955 43019 43023 43038 43045 43265 43987 44425 44457 44614 44780 45462 45463 45477 45902 46845 47439 47449 47470 47474 47485 47487 47497 47501 47519 47540 47541 47793 47808 47810 47812 47814 47819 47824 47826 47835 47837 47841 47846 47859 47863 47871 47886 47890 47892 47897 48040 48045 48062 48065 48067 48070 48077 48086 48088 48112 48119 48122 48124 48126 48134 48155 48157 48159 48172 48181 48299 48377 48438 48440 48442 48446 48450 48459 48462 48464 48479 48505 48559 48561 48563 48565 48567 48569 48571 48573 48576 48578 48637 48656 48658 48663 48667 48671 48673 48675 48689 48690 48721 48781 48784 48800 48805 48816 48818 48824 48826 48931 48933 48935 48937 48941 48949 48951 48989 48995 48998 49000 49011 49020 49044 49047 49049 49051 49055 49066 49143 49158 49184 49230 49232 49235 49237 49270 49272 49275 49280 49283 49799 49892 49893 49894 49896 49903 49904 49917 49918 49919 49920 49923 49926 49927 49928 49929 49936 49937 49939 49940 49998 49999 50212 50516 50764 50765 50766 50767 50768 50769 50796 51325 51326 51327 51409 51410 51416 51417 51418 51419 51423 51424 51490 51505 51730 51988 51991 51992 51993 52127 52129 52131 52134 52136 52138 53005 53006 53199 53200 53223 53225 53226 53248 53249 53301 53351 53600 55050 55090 55258 55259 55260 55261 55265 55270 55359 55458 56641 57330 57622 57720 57721 57992 58431 58580 58581 58649 58652 58699 58703 58731 58737 58741 58746 58751 58755 58756 58771 58773 58785 58789 58794 58795 58801 58803 59156 59158 59161 59163 59170 59171 60051 60052 60219 61005 61295 61299 61300 61649 61846 63668 63669 63670 63671 "