import "./temp/mt19937ar.c.jsx";
import "console.jsx";
import "js/nodejs.jsx";
import "js.jsx";

class _Main {
	static function stringify(f : number) : string {
/*		var a = (f as string);
		a += "0000000000000000";
		return a.substring(0, 10);*/

		var a;
		a = f as string;
		a = a.substring(0, 11);
		if (a.charAt(10) as number > 4) {
			var b = a.substring(2, 10) as number;
			b += 1;
			a = b as string;
			if (a.length < 9) {
				for (var i = a.length; i < 9; ++i) {
					a = "0" + a;
				}
			}
			a = a.substring(0, 1) + "." + a.substring(1, 9);
		} else {
			a = a.substring(0, 10);
		}
		return a;

	}
	static function main (args : string[]) : void {
//		var init = [ 0x123, 0x234, 0x345, 0x456 ];
		var init = (C.cwrap('malloc', 'number', ['number']) as (number) -> number)(4 * 4);
		C.setValue(init+0, 0x123, 'i32');
		C.setValue(init+4, 0x234, 'i32');
		C.setValue(init+8, 0x345, 'i32');
		C.setValue(init+12, 0x456, 'i32');
		EMS.init_by_array(init, 4);
		// log "1000 outputs of genrand_int32()";
		// for (var i = 0; i < 200; ++i) {
		// 	var s = "";
		// 	for (var j = 0; j < 5; ++j) {
		// 		s += EMS.genrand_int32() + " ";
		// 	}
		// 	log s;
		// }
		log "1000 outputs of genrand_real2()";
		function f() : string {
			return _Main.stringify(EMS.genrand_real2());
		}
		for (var i = 0; i < 200; ++i) {
			console.log("%s %s %s %s %s ", f(), f(), f(), f(), f());
		}
	}
}
