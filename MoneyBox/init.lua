-- RRPX Money Printer reworked for DarkRP by philxyz
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.SeizeReward = 950
local Color = Color( 0, 0, 0, 0 )
function ENT:Initialize()
	self:SetModel("models/props_lab/harddrive02.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetColor( Color )
	local phys = self:GetPhysicsObject()
	self.Owner:SetNWInt("Money", self:Getowning_ent())
	phys:Wake()
	
	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")
	concommand.Add("OpenMoneyBox", SetMoney)
end

function ENT:Use(ply)

	if (CurTime() or 1 ) >= (self.KeyPress or 1) then
		umsg.Start("Derma",ply)
		umsg.End()
		self.KeyPress = (CurTime() or 1 ) + 1
	end;
	
end



function ENT:OnRemove(ply)
	DarkRP.notify(ply , 1, 4, "Your MoneyBox is removed")
	umsg.Start("OnRemove",ply)
	umsg.End()
	concommand.Remove("OpenMoneyBox")
	
end

function SetMoney(args)
	RunConsoleCommand("say", args[1])
end