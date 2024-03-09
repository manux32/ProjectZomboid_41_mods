require ('BounderServerDeal')

local patchVehicles = {
	"Base.86oshkoshUSMC", 
	"Base.86oshkoshFRTR55", 
	"Base.86oshkoshKYFD", 
}

for i=1,#patchVehicles do
	RVInterior.shareInterior(patchVehicles[i], "Base.86bounder")
end