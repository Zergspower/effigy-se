import { CheckboxInput, FeatureToggle } from '../../base';

export const show_in_directory: FeatureToggle = {
  name: 'Visible in Character Directory',
  category: 'ERP',
  description: 'When enabled, character will be shown in Directory.',
  component: CheckboxInput,
};
