SWEP.Author                     = ""
SWEP.Contact                    = ""
SWEP.Spawnable                  = true
SWEP.Instructions				= "To BHOP just hold spacebar down once you built up some speed."
SWEP.AdminSpawnable             = false
SWEP.ViewModelFOV			    = 20
SWEP.ViewModel                  = ""
SWEP.HoldType                   = "normal"
SWEP.DrawCrosshair              = false
SWEP.SlotPos                    = 4
SWEP.PrintName 		            = "Bunny Hop"

SWEP.DrawAmmo         			= false
SWEP.DrawCrosshair     			= false

SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = -1
SWEP.Primary.Automatic          = false
SWEP.Primary.Ammo               = "none"
SWEP.Category                   = "CatGuy Sweps"
SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = true
SWEP.Secondary.Ammo             = "none"

function SWEP:Deploy()
    self.Owner:DrawViewModel(false)
end

function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)
    self.Weapon:DrawShadow(false)
    return true
end

function SWEP:CanHop( ent )
	if ( !ent:KeyDown( IN_JUMP ) ) then return false end
	if ( LocalPlayer():IsOnGround() ) then return false end
	if ( LocalPlayer():InVehicle() ) then return false end
	if ( LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP ) then return false end
	if ( LocalPlayer():WaterLevel() >= 2 ) then return false end
	return true
end

function SWEP:DrawHUD()
	local weapon = LocalPlayer():GetActiveWeapon()
	if not IsValid( weapon ) then return end
	if weapon:GetClass() == "bhop_swep" then
		local w, h = 300, 30
		local x, y = math.floor( ScrW() / 2 - w / 2 ), ScrH() - h - 30
		local velocity = LocalPlayer():GetVelocity():Length()
		draw.RoundedBox(0, x, y, velocity / 5, h,Color(0,255,100,205))
		draw.RoundedBox( 0, x-1, y-1, w+2, h+2, Color( 20, 20, 20, 150 ) )
		draw.SimpleText( math.Round(velocity, 0), "Trebuchet24", ScrW() / 2, y + 3, velocity >= 1000 and Color(220, 65, 65, 220) or color_white, TEXT_ALIGN_CENTER )
	end
end

local function hop( ent )
	local weapon = LocalPlayer():GetActiveWeapon()
	if IsValid(weapon) and weapon:GetClass() == "bhop_swep" then
		if weapon.CanHop and weapon:CanHop(ent) then 
			ent:SetButtons( ent:GetButtons() - IN_JUMP )
		end
	end
end
hook.Add("CreateMove", "Hop", hop)

function SWEP:DrawWorldModel() 
	return false 
end

function SWEP:PrimaryAttack()
	return true
end

function SWEP:SecondaryAttack()
	return true
end