<script>
	import { Accordion, AccordionItem } from 'carbon-components-svelte';
	import { Airplane } from 'carbon-pictograms-svelte';
	import { Add } from 'carbon-icons-svelte';
</script>

<Airplane />
<Add />

<Accordion>
	<AccordionItem title="Section 1" open>Content 1</AccordionItem>
	<AccordionItem title="Section 2">Content 2</AccordionItem>
	<AccordionItem title="Section 3">Content 3</AccordionItem>
</Accordion>
