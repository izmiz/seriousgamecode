-- // Decks (SUPER EARLY VERSION, MORE INFORMATION NEEDED LATER)

local Decks = {}

Decks.PsychedelicDeck = {
	{
		Name = "MDMA",
		Conditions = {'PTSD', 'Anxiety'},
		Data = {
			Description = "Known for its empathogenic effects.",
			TherapeuticUses = "Treatment for PTSD, anxiety disorders.",
			Mechanisms = "Increases serotonin, dopamine, and norepinephrine release.",
			History = "Synthesized in 1912, popularized as a therapeutic tool in the 1970s."
		}
	},
	{
		Name = "Psilocybin",
		Conditions = {'PTSD', 'Depression', 'Anxiety'},
		Data = {
			Description = "Active compound in 'magic mushrooms'.",
			TherapeuticUses = "Treating depression, anxiety, addiction, and OCD.",
			Mechanisms = "Serotonin receptor agonist, promoting neuroplasticity.",
			History = "Used in spiritual rituals for centuries, rediscovered in modern psychotherapy."
		}
	},
	{
		Name = "Ketamine",
		Conditions = {'Depression'},
		Data = {
			Description = "A dissociative anesthetic.",
			TherapeuticUses = "Rapid treatment for depression and suicidal thoughts.",
			Mechanisms = "Blocks NMDA receptors, promoting synaptic repair.",
			History = "Developed in the 1960s as an anesthetic, repurposed for mental health in recent decades."
		}
	},
	{
		Name = "Mescaline",
		Conditions = {'PTSD', 'Addiction'},
		Data = {
			Description = "Found in peyote and San Pedro cacti.",
			TherapeuticUses = "Explored for addiction and PTSD treatment.",
			Mechanisms = "Serotonin receptor agonist, influencing perception and mood.",
			History = "Used by indigenous cultures for spiritual ceremonies for thousands of years."
		}
	},
	{
		Name = "Ayahuasca/DMT",
		Conditions = {'Depression', 'Addiction'},
		Data = {
			Description = "A traditional Amazonian brew.",
			TherapeuticUses = "Treatment for depression, trauma, and addiction.",
			Mechanisms = "Activates serotonin receptors, induces vivid introspection.",
			History = "Sacred medicine of indigenous Amazonian tribes."
		}
	},
	{
		Name = "Nitrous Oxide",
		Conditions = {'Depression', 'Anxiety'},
		Data = {
			Description = "A dissociative gas.",
			TherapeuticUses = "Brief relief for depression and anxiety.",
			Mechanisms = "Modulates NMDA and opioid receptors.",
			History = "Used in dentistry and recreationally for centuries."
		}
	},
	{
		Name = "Ibogaine",
		Conditions = {'PTSD'},
		Data = {
			Description = "Derived from the African iboga shrub.",
			TherapeuticUses = "Treating addiction and withdrawal symptoms.",
			Mechanisms = "Acts on serotonin, dopamine, and opioid systems.",
			History = "Traditional medicine of the Bwiti people in Gabon."
		}
	},
	{
		Name = "LSD",
		Conditions = {'Depression', 'Anxiety', 'Addiction'},
		Data = {
			Description = "A potent hallucinogen.",
			TherapeuticUses = "Treatment for depression, anxiety, and cluster headaches.",
			Mechanisms = "Serotonin receptor agonist, affecting perception and cognition.",
			History = "Discovered in 1938, widely researched for therapeutic applications."
		}
	}
}

Decks.ConditionDeck = {
	{
		Name = "Depression",
		Data = {
			Description = "A mood disorder characterized by persistent sadness and loss of interest.",
			Symptoms = "Low energy, hopelessness, difficulty concentrating.",
			Causes = "Can include genetics, brain chemistry, and trauma."
		}
	},
	{
		Name = "PTSD",
		Data = {
			Description = "Caused by severe trauma.",
			Symptoms = "Flashbacks, avoidance behaviors, hypervigilance.",
			Causes = "Military combat, accidents, abuse, and other traumatic events."
		}
	},
	{
		Name = "Anxiety",
		Data = {
			Description = "Excessive worry and fear about everyday situations.",
			Symptoms = "Restlessness, rapid heart rate, difficulty sleeping.",
			Causes = "Combination of genetic, environmental, and psychological factors."
		}
	},
	{
		Name = "Distress",
		Data = {
			Description = "A state of extreme stress and emotional strain.",
			Symptoms = "Irritability, withdrawal, physical symptoms like headaches.",
			Causes = "Chronic stressors like work, relationships, or major life changes."
		}
	},
	{
		Name = "Addiction",
		Data = {
			Description = "Compulsive need for and use of substances or behaviors.",
			Symptoms = "Loss of control, withdrawal symptoms, continued use despite harm.",
			Causes = "Genetic predisposition, environment, and neurochemical changes."
		}
	}
}

return Decks
